# Generated by Django 3.0.2 on 2020-02-08 05:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('grock', '0010_auto_20200208_0535'),
    ]

    operations = [
        migrations.AlterField(
            model_name='disc',
            name='bands',
            field=models.ManyToManyField(blank=True, related_name='discs', to='grock.Band'),
        ),
    ]
