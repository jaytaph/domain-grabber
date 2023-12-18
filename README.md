domains.txt is a list of majestic-millions.csv domains.

spider-html.sh will spider all domains for html files and stores them in html/

spider-css.sh will fetch these html files and extract css in css/


css/inlines-styles.txt is a list of ALL inline styles on html tags:

      <a href="" style="display:none;">

if there are stylesheets within [style][/style] tags, they are added to css/[domain].css.

Otherwise, if there are external stylesheets, they are added by name
