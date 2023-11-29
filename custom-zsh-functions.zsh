
unique_last_occurrences() {
    local -A seen
    local word
    local -a result

    # Read words from stdin
    while read word; do
        seen[$word]=$word
    done

    # Reverse the associative array to maintain last occurrence order
    for word in ${(Oa)seen}; do
        result=($word $result)
    done

    # Print the result
    for word in $result; do
        echo $word
    done
}
