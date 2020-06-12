from django.shortcuts import render
from django.http import HttpResponse
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Movies, Customer, RecommendedMovies, Ratings
from .serializers import MovieSerializer
import ast
import datetime
import time
from rest_framework import filters
from rest_framework import generics

def convert_movie(movie):
    dict_movie = {}
    dict_movie['movie_id'] = movie.movie_id
    dict_movie['timestamp'] = time.mktime(datetime.datetime.strptime(str(movie.release_date), "%m/%d/%Y").timetuple())
    return dict_movie

# def test():
#     movie = Movies.objects.get(movie_id=99885)
#     if (movie.release_date == None):
#         print('No none cmnr')
#     print('release:', movie.release_date)
#     print('type:', type(movie.release_date))

# Create your views here.
@api_view(['GET',])
def get_movie(request, movieId):
    try:
        data = Movies.objects.get(movie_id=movieId)
        mydata = MovieSerializer(data)
        # data_json = {
        #     'id': data.movie_id,
        #     'title': data.title,
        #     'overview': data.overview,
        #     'backdrop_path': data.backdrop_path,
        #     'poster_path': data.poster_path
        # }
        return Response(mydata.data, status=status.HTTP_200_OK)
    except:
        return Response({'message':'movie not found'}, status=status.HTTP_200_OK)

@api_view(['POST',])
def login(request):
    data = request.data
    if data:
        try:
            user = Customer.objects.get(user_name = data['user_name'])
            if data['password'] == user.password:
                res_data = {
                    'success': True,
                    'user_id': user.user_id,
                    'name': user.name,
                    'email': user.email,
                    'adress': user.adress,
                    'birthday': user.birthday,
                    'gender': user.gender
                }
                return Response(res_data, status=status.HTTP_200_OK)
            else:
                return Response({'success': False}, status=status.HTTP_200_OK)
        except:
            return Response({'success': False}, status=status.HTTP_200_OK)
    else:
        return Response({'success': False}, status=status.HTTP_200_OK)

@api_view(['POST',])
def recommendations(request):
    data = request.data
    if data:
        userId = data['user_id']
        try:
            recommendations = RecommendedMovies.objects.get(user = userId)

            movies = Movies.objects.all()

            sorted_movies = sorted(movies, key=lambda x: x.popularity, reverse=True)[0:200]
            popularity_movies = [ele.movie_id for ele in sorted_movies]

            print('truoc for')
            movies2 = []
            for movie in movies:
                if (movie.release_date != None):
                    try:
                        temp = int(str(movie.release_date).split('/')[2])
                        if (temp > 2000):
                            dict_movie = convert_movie(movie)
                            movies2.append(dict_movie)
                    except:
                        pass
            print('sau for')
            sorted_movies = sorted(movies2, key=lambda x: x['timestamp'], reverse=True)[0:10]
            new_movies = [ele['movie_id'] for ele in sorted_movies]

            data_json = {
                'success': True,
                'user_id': userId,
                'recommendations': ast.literal_eval(recommendations.recommendations),
                'popularity': popularity_movies,
                'new': new_movies
            }
            print('len recommendations:', len(data_json['recommendations']))
            return Response(data_json, status=status.HTTP_200_OK)
        except:
            return Response({'success':False}, status=status.HTTP_200_OK)
    else:
        return Response({'success':False}, status=status.HTTP_200_OK)

# @api_view(['GET',])
# def get_popularity_movies(request):
#     try:
#         movies = Movies.objects.all()
#         sorted_movies = sorted(movies, key=lambda x: x.popularity, reverse=True)[0:200]
#         movie_ids = [ele.movie_id for ele in sorted_movies]
#         data_json = {
#             'success': True,
#             'popularity': movie_ids
#         }
#         print('len popularity movies:',len(movie_ids))
#         return Response(data_json,status=status.HTTP_200_OK)
#     except:
#         return Response({'success':False}, status=status.HTTP_200_OK)

class SearchMovies(generics.ListAPIView):
    # queryset = Movies.objects.all()
    # serializer_class = MovieSerializer
    # filter_backends = [filters.SearchFilter]
    # search_fields = ['=title']
    serializer_class = MovieSerializer

    def get_queryset(self):
        queryset = None
        searchText = self.request.query_params.get('title',None)
        #print('searcheText:',searchText)
        if searchText is not None:
            queryset = Movies.objects.filter(title__icontains=searchText)
        return queryset