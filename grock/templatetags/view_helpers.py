from django import template
from datetime import datetime

register = template.Library()

@register.simple_tag
def cc():
    return f'{datetime.now().strftime("%Y%m%d%H%M%S")}'
    
@register.simple_tag
def build_year():
    return f'{datetime.now().year}'

@register.filter(name='times')
def times(number):
    return range(number)

@register.simple_tag
def assets(path):
    return f'./assets/{path}'

@register.simple_tag(takes_context=True)
def root(context):
    layer_num = len(context['request'].path.split('/'))
    if layer_num <= 2:
        return './'
    else:
        return '../' * (layer_num-1)
    