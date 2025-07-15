# Task
Write a BASH script which would make an API call to BookStore service.
https://demoqa.com/swagger/#/
`BookStore/v1/Books`
The result json save into a variable called “books_json” or save it into file book.json.
The result is an object which contains an array of books.
Example of book object:
```json
{
    "isbn": "9781449325862",
    "title": "Git Pocket Guide",
    "subTitle": "A Working Introduction",
    "author": "Richard E. Silverman",
    "publish_date": "2020-06-04T08:48:39.000Z",
    "publisher": "O'Reilly Media",
    "pages": 234,
    "description": "This pocket guide is the perfect on-the-job companion to Git, the distributed version control system. It provides a compact, readable introduction to Git for new users, as well as a reference to common commands and procedures for those of you with Git exp",
    "website": "http://chimera.labs.oreilly.com/books/1230000000561/index.html"
}
```
Iterate through this array. On each iteration create a folder called as “isbn”. In the folder create a file called as “title”. Fill the file with “description”’s value.
So, if books array had 10 objects, you would have 10 folders and 10 files filled with 10 descriptions.  Make the files “read only”.
Parsing json objects should be done via library “jq”. Check it in the script whether it’s installed or not. If it’s not installed, download it via Home brew.
Do the same check with home brew. (If it’s not installed, install it via script). Perform a logging where it’s possible. Provide a key which would make logs to be written in the language provided. Default language is English. So, if I run my command like sh my_bash.sh --set-language Russian, then my logs will be in Russian. (Note: Do only for two languages. English and any which you like. If. you want to make your life easier, you can translate just one line of logs and other leave in English). If I run my command like sh my_bash.sh  (without any key), then default value is taken.

TIPS:
1. In order to make a request, can be used curl. You can copy request from swagger or export it from postman.
2. For any manipulations with json use “jq”. Even though, you can use whatever you want, jq will make life easier. Also, you may want to read about loops in bash.
3. In order to set permissions to a file, explore “chmod” command.
4. There’re many ways to check whether a command is installed or not. You can google how to use “command” for this case. You will need “if” as well.
5. For logging “echo” and/or “printf” will be ok.
6. For parameter reading you will need while, case, test commands. My suggestion will be to google how parameters are processed in bash.