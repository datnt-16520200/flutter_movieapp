from django.db import models

# Create your models here.
class Movies(models.Model):
    belongs_to_collection = models.TextField(blank=True, null=True)
    budget = models.IntegerField(blank=True, null=True)
    genres = models.TextField(blank=True, null=True)
    homepage = models.TextField(blank=True, null=True)
    movie_id = models.IntegerField(primary_key=True)
    original_language = models.TextField(blank=True, null=True)
    title = models.TextField(blank=True, null=True)
    overview = models.TextField(blank=True, null=True)
    popularity = models.FloatField(blank=True, null=True)
    poster_path = models.TextField(blank=True, null=True)
    production_companies = models.TextField(blank=True, null=True)
    release_date = models.TextField(blank=True, null=True)
    revenue = models.BigIntegerField(blank=True, null=True)
    runtime = models.IntegerField(blank=True, null=True)
    tagline = models.TextField(blank=True, null=True)
    vote_average = models.FloatField(blank=True, null=True)
    vote_count = models.IntegerField(blank=True, null=True)
    actor = models.TextField(blank=True, null=True)
    director = models.TextField(blank=True, null=True)
    backdrop_path = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'movies'


class Customer(models.Model):
    user_id = models.IntegerField(primary_key=True)
    user_name = models.TextField()
    password = models.TextField()
    name = models.TextField()
    email = models.TextField()
    adress = models.TextField()
    birthday = models.TextField()
    gender = models.TextField()

    class Meta:
        managed = False
        db_table = 'customer'

class Ratings(models.Model):
    user = models.OneToOneField('Customer', models.DO_NOTHING, primary_key=True)
    movie = models.ForeignKey('Movies', models.DO_NOTHING)
    rating = models.FloatField(blank=True, null=True)
    time_rating = models.BigIntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ratings'
        unique_together = (('user', 'movie'),)

class RecommendedMovies(models.Model):
    user = models.OneToOneField('Customer', models.DO_NOTHING, primary_key=True)
    recommendations = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'recommended_movies'