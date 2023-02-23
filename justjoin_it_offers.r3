REBOL[]

adr: https://justjoin.it/api/offers
;write %offers.json read adr
fhand: to-string read adr
chars_to_replace: charset [#"^"" #"{"]
title: [thru {"title":} copy job_title to "," (append jobs job_title)]
city: [thru {"city":} copy job_city to "," (append jobs job_city)]
salary: [thru {"salary":} copy job_money to "}" (append jobs job_money)]
company: [thru {"company_name":} copy job_company to "," (append jobs job_company)]


jobs: copy[]
rule: [ any [ title company city salary]]
      
parse fhand rule

if not exists? to-file now/date [
foreach [job city money company ] jobs

   [write/binary/append  to-file now/date replace/all 
   rejoin [job ";" city ";" money ";" company newline ]
   chars_to_replace ""]
]


;thru {"employment_types":} copy emp_type to "}}]" (append jobs emp_type)
;thru {"remote":} copy jobs_rem to ","(append jobs rejoin["Remote: " jobs_rem])]]