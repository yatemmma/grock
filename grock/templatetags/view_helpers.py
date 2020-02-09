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

@register.filter("band_name_links")
def band_name_links(key_name_list, root):
    links = []
    for key, name in key_name_list:
        if key is None:
            links.append(name)
        else:
            links.append(f'<a href="{root}band/{key}.html">{name}</a>')
    return mark_safe(','.join(links))

@register.filter("admin_links")
def admin_links(key):
    if settings.IS_ADMIN:
        text = """
            <div class="row">
                <div class="label">edit</div>
                <div class="value ellipsis">
                    <a target="_blank" href="https://grock.herokuapp.com/admin/grock/band/{}/change/">band</a>
                    <a target="_blank" href="https://grock.herokuapp.com/admin/grock/disc/band-{}/change/">playlist</a>
                    <a target="_blank" href="https://grock.herokuapp.com/admin/grock/disc/add/">add_disc</a>
                </div>
            </div>
        """
        return mark_safe(text.format(key, key))
    else:
        return ''

@register.filter("disc_admin_links")
def disc_admin_links(key):
    if settings.IS_ADMIN:
        text = """
            <a target="_blank" href="https://grock.herokuapp.com/admin/grock/disc/{}/change/">playlist</a>
        """
        return mark_safe(text.format(key))
    else:
        return ''

@register.filter("add_admin_link")
def add_admin_link(table):
    if settings.IS_ADMIN:
        text = """
            <a target="_blank" href="https://grock.herokuapp.com/admin/grock/{}/add/">{}</a>
        """
        return mark_safe(text.format(table, table))
    else:
        return ''