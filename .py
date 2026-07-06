def palindrome(word):
    if word[0:] == word[::-1]:
        print("True")
    else:
        print("False")    
palindrome("catcat")