[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/larpon)

# Dead Ascend

A hand-drawn, open source, point'n'click-like 2D adventure game written in Qt/QML and Javascript.

"A horde of Zombies chased you to the old radio tower. Your only chance is to ascend up through the tower - solving a host of puzzles on your way to your rescue."

![Screenshot](https://raw.githubusercontent.com/Larpon/DeadAscend/master/gfx/screenshot.png)

## Quick start

[Black Grain Games](http://games.blackgrain.dk/) are providing pre-build, ad-based, mobile and tablet versions.

 - [Android (Google Play)](https://play.google.com/store/apps/details?id=com.blackgrain.android.deadascend.ad)
 - [iOS (Apple App Store)](https://itunes.apple.com/us/app/dead-ascend/id1197443665?ls=1&mt=8)

By playing the pre-build versions above you are supporting my (indie) game productions.

Dead Ascend is now also available pre-build for [Linux, MacOS and Windows on itch.io](https://blackgrain.itch.io/dead-ascend)

## DIY Building

You can build the game from command line or with [Qt Creator](https://www.qt.io/ide/). QtCreator usually comes bundled with [Qt](https://www.qt.io). It can be downloaded and installed in various ways so please refer to Qt homepage and documentation on howto get Qt Creator.

If you do have [clickable](https://clickable-ut.dev/en/latest/) installed, you can start QtCreator by running `clickable ide qtcreator` in the apps main folder.

Once you have a fully working Qt/Qt Creator setup - you are ready to checkout and build "Dead Ascend".

1. Get codebase from GitHub

   ```
   cd /path/to/projects
   git clone https://github.com/Larpon/DeadAscend.git
   ```
2. Install project dependencies

   ```
   cd /path/to/projects/DeadAscend/extensions/
   git clone https://github.com/Larpon/qak.git
   git clone https://github.com/Larpon/QtFirebase.git
   ```

   **NOTE**<br>
   If you are building for Android and/or iOS you also need to setup [QtFirebase](https://github.com/Larpon/QtFirebase).
   Instructions and a working example is available [here](https://github.com/Larpon/QtFirebaseExample).

3. Build

   a. Qt Creator

      - Open `/path/to/projects/DeadAscend/DeadAscend.pro` in Qt Creator
      - Choose your kit(s)
      - Add custom process step to build profile: Projects -> Build -> Build steps -> `/usr/bin/make` / `assetsrcc` / `%{buildDir}/App`
      ![Extra make target](https://raw.githubusercontent.com/Larpon/DeadAscend/master/docs/img/QtCreatorProjectMakeStep.png)
      - Hit "Run"

   b. Command line

      ```
      cd /path/to/DeadAscend
      # BIN_DIR and ASSETS_DIR are optional
      qmake -r "BIN_DIR=/usr/bin" "ASSETS_DIR=/usr/share/deadascend"
      make assetsrcc -C App
      make
      make install
      ```
      You can now run `./App/DeadAscend` - or if you used `BIN_DIR`: `/usr/bin/DeadAscend`

## Translation

    The app uses QtLinguist translations. You can edit them in the source code, but it is recommended to use [QtCreator](https://www.qt.io/product/development-tools) for your convenience. If you are using QtCreator, configure lupdate and lrelease with the argument set to "App/translations/*.ts".

    **Note: Run all following commands from project root.**

    ### Extract additional strings from scenes.json to a temporary qml-file

    - terminal: `python3 ./sbin/translation.py ./App/assets/scenes/scenes.json`

    ### Translation flow

    a. to extract strings from qml files to ts-files (developers)
    - terminal: lupdate App/App.pro -ts App/translations/*.ts
    - QtCreator
        - configure Linguist: Tools -> Options -> Environment -> Linguist -> lupdate, set Arguments to 'App/App.pro -ts App/translations/*.ts'
        - run lupdate: Tools->External->Linguist->update translations(lupdate)

    b. to update ts-files
    - terminal: linguist App/translations/DeadAscend_*.ts
    - QtLinguist: done automatically, according to [manual](https://doc.qt.io/qt-5/linguist-manager.html)

    c. translate strings
    - in editor: use an editor of your choice to translate strings in the source code, add the translated string between the tags `<translation>add translation here</translation>`
    - QtCreator: right click on translation file, select "open with->QtLinguist", translate using QtLinguist

    d. to update/create qm-files from updated/new ts-files (developers)
    - terminal: lrelease App/translations/*.ts
    - QtCreator
        - configure Linguist: Tools -> Options -> Environment -> Linguist -> lrelease, set Arguments to 'App/translations/*.ts'
        - run lrelease: Tools->External->Linguist->update translations(lrelease)

    ### (optional) get language flags to add to the app for new translations
    https://github.com/hjnilsson/country-flags


## Bugs and issues

If you encounter anything odd with the game feel free to report an [issue](https://github.com/Larpon/DeadAscend/issues).

If you're having trouble with QtFirebase please open an issue on the [QtFirebase project issue page](https://github.com/Larpon/QtFirebase/issues).

## Other game projects

[non - The First Warp](https://store.steampowered.com/app/761730)
