count=0
time_queue={}
--its shell's path
--output_dir='~/Documents/my_cut'--*
--output_file='~/Documents/my_cut/time_pairs.txt'
output_file='~/.config/mpv/scripts/time_pairs.txt'
--c_concat_sh='~/Documents/my_cut/c_concat.sh'
c_concat_sh='~/.config/mpv/scripts/c_concat.sh'
c_concat_sh2='~/.config/mpv/scripts/c_concat2.sh'
--run_sh='~/Documents/my_cut/run.sh'
run_sh='~/.config/mpv/scripts/run.sh'
run_dir='~/.config/mpv/scripts'

--mkdir_sh='if [ ! -d "'..output_dir..'" ]; then mkdir '..output_dir..';fi'

function file_exists(path)
  local file = io.open(path, "rb")
  if file then file:close() end
  return file ~= nil
end

function table_leng(t)
  local leng=0
  for k, v in pairs(t) do
    leng=leng+1
  end
  return leng;
end


function cut_movie()
	count=count+1
	print('count:'..count)
	local time_current=mp.get_property_number('time-pos')
	table.insert(time_queue,time_current)
	if (count%2 == 0)
	then
		print('[right trim is cut]:'..time_current)
        print("time pairs:" .. time_queue[count-1]..','..time_queue[count])
    else
    	print('[left trim is cut]:'..time_current)
    end
    --os.execute('date')--
end
mp.add_key_binding("c", "cut_movie", cut_movie)

function log_time_queue()
	local str = ''
	if(count%2==1)
	then
		print('please confrim the right trim!')
	else
		for k,v in ipairs(time_queue)
		do
			if (k%2==1) then str=str..'['..v..',' else str=str..v..'],'  end
		end

		print('current_pairs:'..string.sub(str,0,#str-1)) str=''
	end
	os.execute('pwd')
end
mp.add_key_binding("l", "log_time_queue", log_time_queue)

function output_queue()
	
	local filename = mp.get_property('filename')
	local file_path = mp.get_property('path')
	local output_dir=string.sub(file_path,0,#file_path - #filename - 1)

	local video_path=mp.get_property('stream-path')
	print('video_path:'..video_path)
	--video_path = string.gsub(video_path, " ", "\\ ")
	print('_video_path:'..video_path)
	local str = ''
	local shell_str = ''
	if(count%2==1)
	then
		print('please confrim the right trim!')
	else
		for k,v in ipairs(time_queue)
		do
			if (k%2==1) then str=str..v..',' else str=str..v..'\\n'  end
		end
		str=string.sub(str,0,#str-2)
		shell_str='echo'..' '..'"'..str..'"'..'>'..' '..output_file
		print('shell:'..shell_str)
		os.execute('pwd')
		--os.execute(mkdir_sh)
		os.execute(shell_str)
		print('shell:'..c_concat_sh .. ' '..output_file..' "'..video_path..'" '..output_dir)
		os.execute(c_concat_sh .. ' "'..output_file..'" "'..video_path..'" "'..output_dir..'" "'..run_dir..'"')
		os.execute(run_sh)

	end
end
mp.add_key_binding("o", "output_queue", output_queue)


function reset_cut()
	count=0
	time_queue={}
	print('cutter reset')
end
mp.add_key_binding("r", "reset_cut", reset_cut)

function set_fromStart()--clean and set 0 to left trim 
	print('set_fromBegin')
	reset_cut()
	count=count+1
	print('count:'..count)
	local time_current=0
	table.insert(time_queue,time_current)

end
mp.add_key_binding("s", "set_fromStart", set_fromStart)

function set_End()--clean and set 0 to left trim 
	
	print('set_set_End')
	-- count=count+1
	-- print('count:'..count)
	-- local time_current=0
	-- table.insert(time_queue,time_current)
	if(count%2==1)
	then
		count=count+1
		local full_time=mp.get_property_number('time-remaining')+mp.get_property_number('time-pos')
		print('full_time:'..full_time)
		table.insert(time_queue,full_time)
		
	else
		print('please confrim the left trim!')

	end

end
mp.add_key_binding("e", "set_End", set_End)

--mp.get_property('stream-path')
function get_path()--clean and set 0 to left trim 
	print(123123)
	os.execute('pwd')
	os.execute('ls')
	print("stream-path:"..mp.get_property('stream-path'))
	print("path:"..mp.get_property('path'))
	print("filename:"..mp.get_property('filename'))
	print("working-directory:"..mp.get_property('working-directory'))
	
	local filename = mp.get_property('filename')
	local file_path = mp.get_property('path')
	local file_dir=string.sub(file_path,0,#file_path - #filename - 1)
	print("file_dir:"..file_dir)

end
mp.add_key_binding("p", "get_path", get_path)

function undo()--clean and set 0 to left trim
    if(count==0)
    then
    	print("cat't undo!")
    else
    	table.remove(time_queue)
		count=count-1
		if(count==0)
		then
			print('undo!time_queue is empty.')
		else
			print('undo!last trim:'..time_queue[count])
		end
		
		
    end 
		
end
mp.add_key_binding("z", "undo", undo)


function acu_output_queue()--精确切割，时间慢
	
	local filename = mp.get_property('filename')
	local file_path = mp.get_property('path')
	local output_dir=string.sub(file_path,0,#file_path - #filename - 1)

	local video_path=mp.get_property('stream-path')
	print('video_path:'..video_path)
	--video_path = string.gsub(video_path, " ", "\\ ")
	print('_video_path:'..video_path)
	local str = ''
	local shell_str = ''
	if(count%2==1)
	then
		print('please confrim the right trim!')
	else
		for k,v in ipairs(time_queue)
		do
			if (k%2==1) then str=str..v..',' else str=str..v..'\\n'  end
		end
		str=string.sub(str,0,#str-2)
		shell_str='echo'..' '..'"'..str..'"'..'>'..' '..output_file
		print('shell:'..shell_str)
		os.execute('pwd')
		--os.execute(mkdir_sh)
		os.execute(shell_str)
		print('shell:'..c_concat_sh2 .. ' '..output_file..' "'..video_path..'" '..output_dir)
		os.execute(c_concat_sh2 .. ' "'..output_file..'" "'..video_path..'" "'..output_dir..'" "'..run_dir..'"')
		os.execute(run_sh)

	end
end
mp.add_key_binding("i", "acu_output_queue", acu_output_queue)


