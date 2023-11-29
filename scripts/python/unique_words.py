#!/usr/bin/env python3

def unique_last_occurrences(words):
    seen = set()
    unique_words = []

    # Iterate in reverse order
    for word in reversed(words):
        if word not in seen:
            seen.add(word)
            unique_words.append(word)

    # Reverse the list to maintain the order of last occurrences
    return unique_words[::-1]

def main():
    # Read words from stdin
    input_words = []
    try:
        while True:
            word = input()
            if word:
                input_words.append(word.strip())
            else:
                break
    except EOFError:
        pass

    # Process and print the unique words
    output_words = unique_last_occurrences(input_words)
    for word in output_words:
        print(word)

if __name__ == "__main__":
    main()
