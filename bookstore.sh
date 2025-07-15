DEFAULT_LANG="en"
URL="https://demoqa.com/BookStore/v1/Books"
RESPONSE_FILE_NAME="response.json"

lang=""

# parse arguments
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

# set language
if [[ -e "./language/$lang.sh" ]]; then
    source "./language/$lang.sh"
    echo $LOG_LANGUAGE_LOADED $lang
else
    source "./language/$DEFAULT_LANG.sh"
    echo $LOG_LANGUAGE_DEFAULT
fi

# make request
echo $LOG_REQUEST
curl -X 'GET' $URL 2>/dev/null > $RESPONSE_FILE_NAME
echo $LOG_SAVE

# get the len of books array
books_len=$(jq '.books | length' $RESPONSE_FILE_NAME)
echo $LOG_LEN $books_len

for (( i = 0; i < $books_len; i++ )); do
    # get dir name as isbn
    book_dir=$(jq -r ".books[${i}].isbn" $RESPONSE_FILE_NAME)

    # get file name as book title
    book_file=$(jq -r ".books[${i}].title" $RESPONSE_FILE_NAME)

    # get book description
    book_desc=$(jq -r ".books[${i}].description" $RESPONSE_FILE_NAME)

    # create dir
    mkdir "./books/$book_dir"
    echo $LOG_DIR_CREATE "./books/$book_dir"

    # save description to file
    echo $book_desc > "./books/$book_dir/$book_file"
    echo $LOG_DESC_WRITE "./books/$book_dir/$book_file"

    # change permissions to read-only
    chmod 444 "./books/$book_dir/$book_file"
    echo $LOG_PERMISSION
done
