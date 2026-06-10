def sentence (word):
    for s in word.split():
        if s[0].lower() == "s":
            print(s)
sentence("Seven silly snakes slowly slithered south")
