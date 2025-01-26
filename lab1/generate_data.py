import random as r
import math as m
import sys

def main():
    cnt = 1000
    towns = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", 
             "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    mds = models(cnt)
    fct = factories(cnt, towns)
    rts = routes(cnt, towns)
    dps = serves(cnt, towns)
    trs = trains(cnt * 10, mds, fct, rts, dps)
    write_csv(mds, "models.csv")
    write_csv(fct, "production.csv")
    write_csv(rts, "routes.csv")
    write_csv(dps, "service.csv")
    write_csv(trs, "trains.csv")
    

def models(cnt):
    ans = ([], dict())
    for id in range(1, cnt + 1):
        r.choices([getrandom, getexisted], weights=[9, 1])[0](ans, id)
    return ans[0]

def getrandom(ans, id):
    year = r.randint(1950, 2023)
    name = str(r.randint(800, 999)) + "-{:02d}".format(year % 100)
    while name in ans[1].keys():
        name = str(r.randint(800, 999)) + "-{:02d}".format(year % 100)
    ans[0].append([id, name, 0, r.randint(40, 80), r.randint(30, 70 + year - 1950)])
    ans[1][name] = (id - 1, year)

def getexisted(ans, id):
    name = r.choice(list(ans[1].keys()))
    year = min(2023, ans[1][name][1] + r.randint(0, 5))
    prev_id = ans[1][name][0]
    ans[0].append([id, name, ans[0][prev_id][2] + 1, max(r.randint(40, 80), ans[0][prev_id][3]), 
                                                     max(r.randint(30, 70 + year - 1950), ans[0][prev_id][4])])
    ans[1][name] = (id - 1, year)

def factories(cnt, towns):
    ans = []
    facts = dict.fromkeys(towns, 0)
    for id in range(1, cnt + 1):
        town = r.choice(towns)
        name = ""
        facts[town] += 1
        name = "Завод №" + str(facts[town])
        ans.append([id, town, name, None, None])
    return ans

def routes(cnt, towns):
    ans = []
    for id in range(1, cnt + 1):
        first = r.choice(towns)
        second = r.choice(towns)
        while first == second:
            second = r.choice(towns)
        ans.append([id, first, second, 500 + r.randint(0, 10) * 50 - 1, False])
    return ans

def serves(cnt, towns):
    ans = []
    depos = dict.fromkeys(towns, 0)
    for id in range(1, cnt + 1):
        town = r.choice(towns)
        name = ""
        depos[town] += 1
        name = "Депо №" + str(depos[town])
        ans.append([id, town, name, None, None])
    return ans

def trains(cnt, mds, fct, rts, dps):
    ans = []
    statuses = ["Действует", "В ремонте"]
    for id in range(1, cnt + 1):
        mid = r.randint(0, len(mds) - 1)
        fid = r.randint(0, len(fct) - 1)
        rid = r.randint(0, len(rts) - 1)
        sid = r.randint(0, len(dps) - 1)
        year = r.randint(1950, 2023)
        inoos = r.choices([True, False], [50, 2024 - year])[0]
        status = "Снят с эксплуатации"
        if inoos:
            status = r.choices(statuses, [500, 2050 - year])[0]
            rts[rid][4] = True
        ans.append([id, mid + 1, fid + 1, rid + 1, sid + 1, year, status])
        if fct[fid][3] is None:
            fct[fid][3] = year
            fct[fid][4] = r.randint(year, 2030)
        else:
            fct[fid][3] = min(fct[fid][3], year)
            fct[fid][4] = max(fct[fid][4], r.randint(year, 2030))
        if dps[sid][3] is None:
            dps[sid][3] = year
            dps[sid][4] = 2024 if inoos else r.randint(year, 2023)
        else:
            dps[sid][3] = min(dps[sid][3], year)
            dps[sid][4] = 2024 if inoos else max(dps[sid][4], r.randint(year, 2023))
    for f in fct:
        if f[-1] is None:
            f[-2] = r.randint(1950, 2023)
        elif f[-1] > 2023:
            f[-1] = None
    for d in dps:
        if d[-1] is None:
            d[-2] = r.randint(1950, 2023)
        elif d[-1] > 2023:
            d[-1] = None
    return ans

def write_csv(lst, filename=""):
    file = sys.stdout
    file2 = sys.stdout
    flag = False
    if filename != "":
        file = open("/usr/local/postgres/" + filename, "w")
        file2 = open(filename, "w")
        flag = True
    first = True
    for line in lst:
        out = ""
        for i in range(len(line)):
            if line[i] is not None:
                if i > 0:
                    out = out + ";" + str(line[i])
                else:
                    out = str(line[i])
            elif i > 0:
                out = out + ";"
        out = out + '\n'
        file.write(out)
        if flag:
            file2.write(out)
            if first:
                file.write(out)
                file2.write(out)
                first = False
    if flag:
        file.close()
        file2.close()

if __name__ == "__main__":
    main()