import psycopg2
import pandas as pd
import ast
import random
import datetime

def random_date():
    start_date = datetime.date(1950, 1, 1)
    end_date = datetime.date(2002, 1, 1)

    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    random_date = start_date + datetime.timedelta(days=random_number_of_days)
    return random_date

connection = psycopg2.connect("host='localhost' dbname='movies_db_demo' user='postgres' password='tiendat148'")
mycursor = connection.cursor()
ratings = pd.read_csv('./data/ratings_70.csv')

users = ratings['userId'].drop_duplicates().tolist()
len_users = len(users)

file_names = open('./data/names.txt','r')
names = file_names.readline()
names = ast.literal_eval(names)
file_names.close()

file_adress = open('./data/adress.txt','r')
adress = file_adress.readline()
adress = ast.literal_eval(adress)
file_adress.close()

dem = 1

for userId in users:
    name_index = random.randint(0,len(names)-1)
    adress_index = random.randint(0,len(adress)-1)

    user_name = 'user_'+str(userId)
    password = 'user_'+str(userId)
    name = names[name_index]
    email = str(name).lower() + '@gmail.com'
    location = adress[adress_index]
    birthday = random_date()
    gender = 'male' if name_index < 100 else 'female'

    sql = "INSERT INTO customer VALUES (" + str(userId) + ",'" + user_name + "','" + password + "','" + name + "','" + email + "','" + location + "','" + str(birthday) + "','" + gender + "'" + ")"

    try:
        mycursor.execute(sql)
        connection.commit()
        print(dem,'/',len_users)
        dem += 1
    except:
        connection.rollback()