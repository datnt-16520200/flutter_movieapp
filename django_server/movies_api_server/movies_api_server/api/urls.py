from django.urls import path
from . import views

urlpatterns = [
    path('movie/<int:movieId>', views.get_movie, name='get_movie'),
    path('login',views.login, name='login'),
    path('recommendations',views.recommendations,name='recommendations'),
    # path('popularity_movies',views.get_popularity_movies,name='popularity_movies'),
    path('search_movies',views.SearchMovies.as_view(),name='search_movies')
]