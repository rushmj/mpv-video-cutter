# mpv-video-cutter   
Before using it,mpv and ffmpeg should be installed.support mac os x and linux,if you want it supports windows,you can write CMD instead of Bash Shell.  

   it can cut video and concat automatically  
put **c_concat.sh** , **cutter.lua** into ~/.config/mpv/scripts/,then use shell:mpv path/file open the movie
press c will confirm a left trim,then press c you will confirm a right trim,left and right trim ensure one segment,you can continue do this,at last press key o,the video will be cut and concatenated in the video's dir automatically.
this script uses the FFmpeg to finish the job,and is lossless cutting,the cut video will not lose quality. 

* **press key c** : cut point,the odd times is letf trim, the even times is right trim
* **press key o** : output the cut video and concat
* **press i** : output the accurate time cut video and concat
* **press key r** : reset,clean the queue that record the cut point
* **press s** : reset,and set the first cut point(left trim) in 0 second.
* **press e** : set the right trim in the end time of the video
* **press z** : undo the cut


also you can bind your own hot key to the event.
I have defined some event you can bind it in the ~/.config/mpv/input.conf,for example:Ctrl+s script-binding set_fromStart
here are them:
* **cut_movie** : cut time point,default key 'c'
* **log_time_queue** : print the queue that record the cut point,defalut key 'l'
* **output_queue** : output video,default key 'o'
* **set_fromStart** : reset,and set the first cut point(left trim) in 0 second,default key 's' 
* **set_End** : set the right trim in the end time of the video,default key 'e'
* **acu_output_queue** : accurate time cut 
* **undo** : undo


In fact,I should also add some more function like GUI editor?
