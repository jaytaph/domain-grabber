#!/bin/bash

html_file="$1"
domain=$(basename $html_file .html)

styles=()
while read -r style; do
    styles+=("$style")
done < <(pcregrep -M '<style>[\s\S]*?</style>' "$html_file")

#styles=$(pcregrep -M '<style>[\s\S]*?</style>' "$html_file")
#styles=$(grep -o -P '<style>[\s\S]*?</style>' "$html_file")
css_links=$(grep -o -E 'link[^>]*href="([^"]+\.css)"' "$html_file" | sed -E 's/.*href="([^"]+)".*/\1/g')
inline_styles=$(grep -o -E 'style="([^"]+)"' "$html_file" | sed -E 's/.*style="([^"]+)".*/\1/g')
#inline_styles=$(awk -F 'style="' '/style="/{gsub(/".*/, "", $2); print $2}' "$html_file")


echo "=== STYLES ===="
for style in "${styles[@]}"; do
    echo "$style" >> css/$domain.css
done

#if [[ ! -z "${styles// }" ]]; then
#  echo $styles > css/$domain.css
#fi

echo "=== CSS LINKS ===="
echo "$css_links" | while IFS=$'\n' read -r item; do
    if [ -z $item ] ; then
      continue;
    fi

    if [[ "$item" =~ ^// ]]; then
        item=${item:1}
    fi
    if [[ ! "$item" =~ ^https?:// ]]; then
        echo https://$domain$item
        curl -sL https://$domain$item -o css/$(basename $item)
    else
        echo $item
        curl -sL $item -o css/$(basename $item)
    fi
done

echo "=== INLINE STYLES ===="

echo "$inline_styles" | while IFS=$'\n' read -r item; do
    echo $item >> css/inlines-styles.txt
done
