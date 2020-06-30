# algorithm from (LESSICOGRAFICO):
# https://www.quora.com/How-would-you-explain-an-algorithm-that-generates-permutations-using-lexicographic-ordering
#
# 1 - Find the largest x such that P[x]<P[x+1]. (If there is no such x, P is the last permutation.)
# 2 - Find the largest y such that P[x]<P[y].
# 3 - Swap P[x] and P[y].
# 4 - Reverse P[x+1 .. n].

elements = [1, 2, 3]


# primo modo: algo 1 ---> permutazioni lessicografiche
def lexiPerm(el, n=None):

    # n = None ---> N! permutazioni
    permutazioni = {}
    count = 1
    while(True):

        # generatore
        yield(el)

        x_largest = -1 # -1 in modo da passargli il mancato indice
        for i in range(len(el) - 1):
            if(el[i] < el[i + 1]):
                x_largest = i


        print(x_largest)
        if(n == None):
            if(x_largest == -1):
                break
        else:
            if(x_largest == -1 or count >= n):
                break

        y_largest = -1
        for j in range(len(el)):
            if(el[x_largest] < el[j]):
                y_largest = j

        # swap
        el[x_largest], el[y_largest] = el[y_largest], el[x_largest]
        el = el[:x_largest + 1] + el[:x_largest:-1]
        count += 1

num_perm = None
a = lexiPerm(elements)
for i in a:
    print(i)


# modo 2:
# simple permutation ---> modo ricorsivo
def simplePerm(data):
    l = len(data)
    if(l == 1):
        return([data])
    else:
        perm = []
        for i in range(l):
            y = data[:i] + data[i + 1:]
            result = simplePerm(y)
            for r in result:
                perm.append([data[i]] + r)
        return(perm)

def printArray(arr):
    for a in arr:
        print(a, "", end="\n")
    print()

elem = [1, 2, 3, 4, 5, 6]
# perm = simplePerm(elem)
# printArray(perm)


# Heap's algorithm
# n! permutazioni
# se indice i pari, allora swap tra il primo e l'ultimo elemento; se i dispari swap tra i-esimo elemento e ultimo
def heap(datas):
    l = len(datas)
    p = [0 for x in range(l)]
    r = []

    r.append(list(datas))

    i = 0
    while(i < l):
        if(p[i] < i):
            if(i%2 == 0):
                datas[0], datas[i] = datas[i], datas[0]
            else:
                datas[p[i]], datas[i] = datas[i], datas[p[i]]
            r.append(list(datas))
            p[i] += 1
            i = 0
        else:
            p[i] = 0
            i += 1

    return(r)

# a = heap(elem)
# printArray(a)
# print("n!:", len(a))
