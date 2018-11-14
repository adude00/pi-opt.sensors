import urllib2
import json
#f = urllib2.urlopen('http://api.wunderground.com/api/576e79ea050e0d1d/conditions/q/pws:IBOLOGNA194.json')
f = urllib2.urlopen('http://api.wunderground.com/api/576e79ea050e0d1d/conditions/q/IT/Bologna.json')
json_string = f.read()
parsed_json = json.loads(json_string)
temp_c = parsed_json['current_observation']['temp_c']
pressure_mb = parsed_json['current_observation']['pressure_mb']
relative_humidity = parsed_json['current_observation']['relative_humidity']
print "%s:%s:%s" % (temp_c, relative_humidity, pressure_mb)
f.close()
