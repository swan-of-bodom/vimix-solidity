syn match	qfFileName	/.*contract$/
syn match filepath /.*Context\.<anonymous>.*/ conceal cchar=/
hi qfFileName guifg=LightGoldenrod1

syn match coverage /.*--.*/
syn match failing /.*failing.*/
syn match failing /.*AssertionError.*/
" update syn match failed /✔.*/
syn match passing /.*passing.*/
syn match passed /✔.*/
syn match coverage /|/
syn match sections /.*==.*/

hi coverage guifg=LightGoldenrod1
hi passed guifg=#95C561
hi passing guifg=#95C561
hi failing guifg=#EE6D85
hi sections guifg=#38A89D

setlocal conceallevel=3
setlocal concealcursor=nvi
set wfw
set nonumber

syntax match keyword "||" conceal cchar=/
