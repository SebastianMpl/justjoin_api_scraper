REBOL[]

just-join: https://justjoin.it/api/offers
rocket-jobs: https://api.rocketjobs.pl/v2/user-panel/offers

store-data: function [api-url] [
either not exists? to-file now/date [
fhand: to-string read api-url 
]
[print "File for today is already available locally." quit]

chars_to_replace: charset [#"^"" #"{" #"}"]

title: [thru {"title":} copy job_title to "," (append jobs job_title)]
city: [thru {"city":} copy job_city to "," (append jobs job_city)]
company: [thru {"company_name":} copy job_company to "," (append jobs job_company)]
pub_date: [thru {"published_at":} copy publication_date to "T" (append jobs publication_date)]
emp_type: [thru {"employment_types":[^{} copy employment_form to "]" (append jobs employment_form)]


jobs: copy[]
rule: [ any [ title city company pub_date emp_type ]]
      
parse fhand rule

foreach [job city company date emp] jobs

   [write/binary/append  to-file now/date replace/all 
   rejoin [job ";" city ";" company ";" date ";" emp newline ]
   chars_to_replace ""]

print "Download complete"
]
site: ask {Which offers to fetch?
           1: justjoin.it
           2: rocketjobs.pl
           3: quit
           }
switch to-integer site [
1 [store-data to-url just-join]
2 [store-data to-url rocket-jobs]
3 [quit]
]
