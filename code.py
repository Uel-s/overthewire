def count_cases(words):
    upper = 0
    lower = 0
    for char in words.split():
        if char.isupper():
            upper+=1
        elif char.islower():   
            lower+=1  
    print(f"The number of capitalized words is {upper}") 
    print(f"The number of lower cases is {lower}")       
count_cases("CHECK the number of count for UpperCases and lowercases")        