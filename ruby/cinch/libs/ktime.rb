def tflog
ctime = Time.now
ftime = ctime.month.to_s+"/"+ctime.day.to_s+"/"+ctime.year.to_s+" "+ctime.hour.to_s+":"+ctime.min.to_s+":"+ctime.sec.to_s
return ftime
end
