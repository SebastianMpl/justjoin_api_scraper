REBOL[]

adr: https://justjoin.it/api/offers
;write %offers.json read adr
fhand: to-string read adr
chars_to_replace: charset [#"^"" #"{"]

title: [thru {"title":} copy job_title to "," (append jobs job_title)]
city: [thru {"city":} copy job_city to "," (append jobs job_city)]
company: [thru {"company_name":} copy job_company to "," (append jobs job_company)]


jobs: copy[]
rule: [ any [ title company city ]]
      
parse fhand rule

if not exists? to-file now/date [
foreach [job company city] jobs

   [write/binary/append  to-file now/date replace/all 
   rejoin [job ";" company ";" city newline ]
   chars_to_replace ""]
]


;thru {"employment_types":} copy emp_type to "}}]" (append jobs emp_type)
;thru {"remote":} copy jobs_rem to ","(append jobs rejoin["Remote: " jobs_rem])]]