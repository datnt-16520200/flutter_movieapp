import psycopg2
import pandas as pd
import numpy as np
import datetime
from sklearn.metrics.pairwise import cosine_similarity

connection = psycopg2.connect("host='localhost' dbname='movies_db_demo' user='postgres' password='tiendat148'")
mycursor = connection.cursor()

class User_User_CF(object):
    def __init__(self, userId, rated_movies):
        """Constructor of class User_User_CF
        Parameters:
        + ratings: is the ratings dataframe (type 'Dataframe').
        + userId: id of user that you want to recommend movies to (type 'int').
        + rated_movies: the movies which user 'userId' voted for"""
        self.userId = userId
        
        # find the others users who also rate movies in 'rated_movies'
        self.similarity_ratings = None
        
        self.list_items_id = rated_movies

        # list_users_id contains users who rate movies in 'rated_movies'
        self.list_users_id = []
        # number of users
        self.n_users = 0
        # number of items
        self.n_items = len(self.list_items_id)

        # Matrix user_item with column is item, row is user and value is rating 
        self.Ybar_data = None

        # scores_users_sim contains users that are similar to 'userId'
        self.scores_users_sim = None

    def process_attributes(self):
        """Process the attributes if it is not processed in the contructor"""
        query_string = """select user_id
                        from ratings
                        where movie_id in ("""+str(rated_movies).replace('[','').replace(']','')+""")
                        group by user_id
                        having count(user_id) > """ + str(int(0.5*len(rated_movies)))
        mycursor.execute(query_string)
        query_result = mycursor.fetchall()

        # add userId to list_users_id after filtering
        self.list_users_id = [ele[0] for ele in query_result]
        self.n_users = len(self.list_users_id)

        # similarity_ratings contains ratings of users in 'list_users_id'
        query_string = "select * from ratings where user_id in ("+str(self.list_users_id).replace('[','').replace(']','')+") and movie_id in ("+str(self.list_items_id).replace('[','').replace(']','')+")"
        mycursor.execute(query_string)
        query_result = mycursor.fetchall()
        self.similarity_ratings = pd.DataFrame(query_result, columns=['userId','movieId','rating','timestamp'])
        mean = {}
        for user in self.list_users_id:
            mean[user] = (self.similarity_ratings[self.similarity_ratings.userId==user].rating).mean()
        # Generate Ybar_data which has 'n_users' rows and 'n_items' columns
        self.Ybar_data = pd.DataFrame(data=np.zeros((self.n_users,self.n_items)),index=self.list_users_id,columns=self.list_items_id)

        #set ratings value in Ybar_data
        for row in self.similarity_ratings.itertuples():
            self.Ybar_data.loc[row.userId,row.movieId] = row.rating - mean[row.userId]

    def calculate_similarity(self):
        """Calculate the similarity
        between 'userId' and other users"""
        # get data about rating of 'userId' from Ybar_data and convert to numpy array
        row_user = [(self.Ybar_data.loc[self.userId,:]).to_numpy()]
        # convert Ybar_data to numpy array
        Ybar = self.Ybar_data.to_numpy()
        # Calculate the similarity
        cosine_sim = cosine_similarity(row_user,Ybar)

        # Sort users in descending order of similarity with 'userId'
        temp = cosine_sim[0].tolist()
        similar_users = list(zip(self.list_users_id,temp))
        similar_users = sorted(similar_users, key=lambda x: x[1], reverse=True)[1:6]

        # assign the result to 'scores_users_sim' as a dict
        self.scores_users_sim = dict(similar_users)
        # edit 'similarity_ratings' only contains rating of users in 'scores_users_sim'
        query_string = "select * from ratings where user_id in ("+str(list(self.scores_users_sim.keys())).replace('[','').replace(']','')+")"
        mycursor.execute(query_string)
        query_result = mycursor.fetchall()
        self.similarity_ratings = pd.DataFrame(query_result, columns=['userId','movieId','rating','timestamp'])
    
    def run(self):
        """Handles attributes and calculates similarities between found users"""
        self.process_attributes()
        self.calculate_similarity()

    def get_recommend_movies(self):
        """The func will find some movies to recommend to 'userId'
        **Return: list of movieId"""
        movies_df = self.similarity_ratings.copy()
        # filter and keep movies whose rating > 0
        movies_df = movies_df.query('rating > 0')
        movies = movies_df['movieId'].unique().tolist()
        recommend_movies = [movie for movie in movies if movie not in self.list_items_id]
        return recommend_movies

    def pred(self,item):
        """Predict the rating of 'userId' with 'item'
        **Return: a float number."""
        ratings_item = self.similarity_ratings[self.similarity_ratings['movieId']==item].copy()

        tu = 0
        mau = 0
        for k in self.scores_users_sim.keys():
            mau += self.scores_users_sim[k]
        for row in ratings_item.itertuples():
            tu += (self.scores_users_sim[row.userId] * row.rating)
        
        return tu/mau

    def recommend(self):
        """Recommed movies to 'userId'
        **Return: a list of movieId is sorted in descending order by rating"""
        recommend_movies = self.get_recommend_movies()
        sort_movies = []

        # predict the rating and add movies to sort_movies
        for i in recommend_movies:
            rating = self.pred(i)
            sort_movies.append((i,rating))

        # sort movies by descending order of rating
        sort_movies = sorted(sort_movies,key=lambda x: x[1], reverse=True)[:200]

        return sort_movies
    
    def info(self):
        """Print some information about this object"""
        print('userId:',self.userId)
        print('n_users:',self.n_users)
        print('n_items:',self.n_items)
        print('similarity_ratings shape:',self.similarity_ratings.shape)
        print(self.Ybar_data.head())


# x = datetime.datetime.now()
# print(x)

userIds = [8, 9, 11, 12, 15, 16, 20]
list_recommend_for_userIds = {}

for userId in userIds:
    mycursor.execute("select movie_id from ratings where user_id = "+str(userId))
    query_result = mycursor.fetchall()
    rated_movies = [ele[0] for ele in query_result]

    # train = rated_movies[:int(0.8*len(rated_movies))].copy()
    # test = [ele for ele in rated_movies if ele not in train]

    user_user_cf = User_User_CF(userId,rated_movies)
    user_user_cf.run()

    sort_recommend_movies = user_user_cf.recommend()

    list_recommend_for_userIds[userId] = [ele[0] for ele in sort_recommend_movies]


recommend_file = open('./data/recommend.txt', 'w')
recommend_file.write(str(list_recommend_for_userIds))

recommend_file.close()
# y = datetime.datetime.now()

# true_recommend = []
# for i in sort_recommend_movies:
#     if i[0] in test:
#         true_recommend.append(i)

# print('test:',test)
# print('so recommend:',len(sort_recommend_movies))
# print('so phim dung:',len(true_recommend))
# print('ti le 1:',len(true_recommend)/len(test))
# print('ti le 2:',len(true_recommend)/len(sort_recommend_movies))
# print('id dung:',true_recommend)
# print(y)
# print('thoi gian chay:', y-x)



mycursor.close()
connection.close()