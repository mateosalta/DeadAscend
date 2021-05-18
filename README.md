[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/larpon)

# Dead Ascend

A hand-drawn, open source, point'n'click-like 2D adventure game written in Qt/QML and Javascript.

"A horde of Zombies chased you to the old radio tower. Your only chance is to ascend up through the tower - solving a host of puzzles on your way to your rescue."

![Screenshot](https://raw.githubusercontent.com/Larpon/DeadAscend/master/gfx/screenshot.png)

## Quick start


[![OpenStore](https://open-store.io/badges/en_US.svg)](https://open-store.io/app/deadascend.mateo-salta)

## DIY Building


1. Get codebase from GitHub

   ```
   cd /path/to/projects
   git clone https://github.com/mateosalta/DeadAscend.git
   git checkout ut
   ```


3. Build



    Command line
   
 - Run clickable for your arch in the main project folder

      ```
      clickable
      clickable --arch=arm64
      clickable --arch=amd64
      ```
      
   clickable will error on 'manifest.json not found'
   
  - Copy the binary file from the build folder to /App/platforms/ubuntutouch/DeadAscend
  - Run clickable for your arch within /App/platforms/ubuntutouch
     
     

- qtfirebase is 'stub' implementation only on 'other platforms' so it is left unconfigured and will not show ads
