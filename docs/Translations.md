
# Prepare strings

Run all following commands from project root.

# Extract strings from scenes.json to a temporary qml-file
python ./sbin/translation.py ./App/assets/scenes/scenes.json

# Translation flow

Developers, to extract strings from qml files to ts-files:
lupdate App.pro -ts App/translations/*.ts

Translator, to update ts-files:
linguist App/translations/DeadAscend_*.ts

Developers, to update/create qm-files from updated/new ts-files:
lrelease App/translations/*.ts

# Flags
https://github.com/hjnilsson/country-flags
