from rest_framework import serializers
from .models import Movies

class MovieSerializer(serializers.ModelSerializer):
    class Meta:
        model = Movies
        fields = [
            'belongs_to_collection',
            'budget',
            'genres',
            'homepage',
            'movie_id',
            'original_language',
            'title',
            'overview',
            'popularity',
            'poster_path',
            'production_companies',
            'release_date',
            'revenue',
            'runtime',
            'tagline',
            'vote_average',
            'vote_count',
            'actor',
            'director',
            'backdrop_path',
        ]