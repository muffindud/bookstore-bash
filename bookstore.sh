# URL="https://demoqa.com/BookStore/v1/Books"
# curl -X 'GET' $URL > response.json

books_len=$(jq '.books | length' response.json)

for (( i = 0; i < $books_len; i++ ))
do
    # echo $(jq ".books[${i}]" response.json)
    book_dir=$(jq -r ".books[${i}].isbn" response.json)
    book_file=$(jq -r ".books[${i}].title" response.json)
    book_desc=$(jq -r ".books[${i}].description" response.json)
    mkdir books/$book_dir
    echo $book_desc > books/$book_dir/"$book_file"
    chmod 444 books/$book_dir/"$book_file"
done
