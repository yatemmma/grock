from django import template
from datetime import datetime
from django.utils.safestring import mark_safe
from django.conf import settings
import flag


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
    layer_num = len(context['request'].path_info.split('/'))
    if layer_num <= 1:
        return './'
    else:
        return '../' * (layer_num-1)

@register.filter("emoji")
def to_emoji(value):
    if value:
        return flag.flagize(f':{value}:')
    elif value is None:
        return ''
    else:
        return value

@register.filter("even_row")
def even_row(index):
    if index % 2 == 0:
        return "odd-row"
    else:
        return "even-row"

@register.filter("external_link")
def external_link(url):
    if url:
        return mark_safe( f'<a target="_blank" href="{url}">{url}</a>' )
    else:
        return ""

@register.filter("none_to_empty")
def none_to_empty(text):
    if text is None:
        return ""
    else:
        return text

@register.filter("admin_links")
def admin_links(key):
    if settings.DEBUG:
        text = """
            <div class="row">
                <div class="label">edit</div>
                <div class="value ellipsis">
                    <a target="_blank" href="https://grock.herokuapp.com/admin/grock/band/{}/change/">band</a>
                    <a target="_blank" href="https://grock.herokuapp.com/admin/grock/disc/band-{}/change/">playlist</a>
                </div>
            </div>
        """
        return text.format(key, key)
    else:
        return ''