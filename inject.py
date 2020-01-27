import sys
from jinja2 import Template

with open(sys.argv[1], 'w') as file:
    with open('crontab.template') as template:
        file.write(Template(template.read()).render(CRON=sys.argv[2], COMMAND=sys.argv[3]))