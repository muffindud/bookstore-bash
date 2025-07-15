DEFAULT_LANG="en"
URL="https://demoqa.com/BookStore/v1/Books"
RESPONSE_FILE_NAME="response.json"

lang=""
lang_present=1

while [[ $# -gt 0 ]]; do
    key=$1
    case $key in
    -l | --set-language)
        lang=$2
        shift
        shift
        ;;
    *)
        shift
        ;;
    esac
    shift
done

if [[ -e "./language/$lang.sh" ]]; then
    source "./language/$lang.sh"
    echo $LOG_LANGUAGE_LOADED $lang
else
    source "./language/$DEFAULT_LANG.sh"
    echo $LOG_LANGUAGE_DEFAULT
fi

echo $LOG_REQUEST
curl -X 'GET' $URL 2>/dev/null > $RESPONSE_FILE_NAME
echo $LOG_SAVE

books_len=$(jq '.books | length' $RESPONSE_FILE_NAME)
echo $LOG_LEN $books_len

for (( i = 0; i < $books_len; i++ )); do
    book_dir=$(jq -r ".books[${i}].isbn" $RESPONSE_FILE_NAME)
    book_file=$(jq -r ".books[${i}].title" $RESPONSE_FILE_NAME)
    book_desc=$(jq -r ".books[${i}].description" $RESPONSE_FILE_NAME)
    mkdir "./books/$book_dir"
    echo $LOG_DIR_CREATE "./books/$book_dir"

    echo $book_desc > "./books/$book_dir/$book_file"
    echo $LOG_DESC_WRITE "./books/$book_dir/$book_file"

    chmod 444 "./books/$book_dir/$book_file"
    echo $LOG_PERMISSION
done
