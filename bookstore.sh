lang="en"

if [[ ! $1 = "--set-language" ]]; then
    source "language/$lang.sh"
    echo $LOG_LANGUAGE_NOT_SPECIFIED
elif [[ -e "./language/$2.sh" ]]; then
    lang=$2
    source "language/$lang.sh"
    echo $LOG_LANGUAGE_FOUND
else
    source "language/$lang.sh"
    echo $LOG_LANGUAGE_NOT_FOUND
fi
echo $LOG_LANGUAGE_SET $lang

URL="https://demoqa.com/BookStore/v1/Books"
echo $LOG_REQUEST

curl -X 'GET' $URL 2>/dev/null > response.json
echo $LOG_SAVE

books_len=$(jq '.books | length' response.json)
echo $LOG_LEN $books_len

for (( i = 0; i < $books_len; i++ )); do
    book_dir=$(jq -r ".books[${i}].isbn" response.json)
    book_file=$(jq -r ".books[${i}].title" response.json)
    book_desc=$(jq -r ".books[${i}].description" response.json)
    mkdir books/$book_dir
    echo $LOG_DIR_CREATE "books/$book_dir"

    echo $book_desc > books/$book_dir/"$book_file"
    echo $LOG_DESC_WRITE "books/$book_dir/\"$book_file\""

    chmod 444 books/$book_dir/"$book_file"
    echo $LOG_PERMISSION
done
