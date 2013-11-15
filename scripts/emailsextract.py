f = open('emails.txt', 'r')
o = open('emailsextract.txt', 'w')

s = f.read()
print s
s = s.split('\n')
print s

i = len(s)

print i
j = 0;
k=''
while (j<i):
    s[j] = s[j] + ','
    j = j + 1
print s

o.write("\n".join(s))
