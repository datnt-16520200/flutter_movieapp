import psycopg2
import ast

connection = psycopg2.connect("host='localhost' dbname='movies_db_demo' user='postgres' password='tiendat148'")
mycursor = connection.cursor()

recommed_file = open('./data/recommend.txt','r')
recommendations = recommed_file.readline()
recommendations = ast.literal_eval(recommendations)

print('type recommendations:', type(recommendations))
print('type recommendations[8]:', type(recommendations[8]))
print('len recommendations[8]:',len(recommendations[8]))

for userId in recommendations.keys():
    recommended = recommendations[userId]
    sql = "INSERT INTO recommended_movies VALUES (" + str(userId) + ",'" + str(recommended) + "')"

    try:
        mycursor.execute(sql)
        connection.commit()
    except:
        print('1 error!')
        connection.rollback()

print('Insert success!')