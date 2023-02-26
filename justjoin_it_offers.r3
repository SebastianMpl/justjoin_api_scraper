REBOL[]

adr: https://justjoin.it/api/offers
fhand: to-string read adr
chars_to_replace: charset [#"^"" #"{" #"}"]

title: [thru {"title":} copy job_title to "," (append jobs job_title)]
city: [thru {"city":} copy job_city to "," (append jobs job_city)]
company: [thru {"company_name":} copy job_company to "," (append jobs job_company)]
pub_date: [thru {"published_at":} copy publication_date to "T" (append jobs publication_date)]
emp_type: [thru {"employment_types":[^{} copy employment_form to "]" (append jobs employment_form)]


jobs: copy[]
rule: [ any [ title city company pub_date emp_type ]]
      
parse fhand rule

if not exists? to-file now/date [
foreach [job city company date emp] jobs

   [write/binary/append  to-file now/date replace/all 
   rejoin [job ";" city ";" company ";" date ";" emp newline ]
   chars_to_replace ""]
]