# Generated by Django 3.0.2 on 2020-02-02 15:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('grock', '0007_delete_disc'),
    ]

    operations = [
        migrations.CreateModel(
            name='Disc',
            fields=[
                ('key', models.CharField(max_length=400, primary_key=True, serialize=False)),
                ('title', models.CharField(max_length=400)),
                ('disc_type', models.CharField(max_length=20)),
                ('release_date', models.CharField(blank=True, max_length=20, null=True)),
                ('image', models.URLField(blank=True, null=True)),
                ('youtube_ids', models.TextField(blank=True, null=True)),
                ('wiki', models.URLField(blank=True, null=True)),
                ('youtube', models.URLField(blank=True, null=True)),
                ('apple', models.URLField(blank=True, null=True)),
                ('google', models.URLField(blank=True, null=True)),
                ('amazon', models.URLField(blank=True, null=True)),
                ('spotify', models.URLField(blank=True, null=True)),
                ('soundcloud', models.URLField(blank=True, null=True)),
                ('bandcamp', models.URLField(blank=True, null=True)),
                ('note', models.TextField(blank=True, null=True)),
            ],
        ),
    ]
