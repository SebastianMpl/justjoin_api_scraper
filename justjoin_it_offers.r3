REBOL[]
;
;;Command that scrapes the same data with xidel tool
;;./xidel https://justjoin.it/api/offers -e 'for $node in $json() return string-join((
;;   $node/title, $node/city, $node/company_name, $node/published_at, $node/employment_types/type, 
;;   $node/employment_types/salary/from, $node/employment_types/salary/to, $node/employment_types/currency), ",")'

either not exists? to-file now/date [
adr: https://justjoin.it/api/offers
fhand: to-string read adr
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
