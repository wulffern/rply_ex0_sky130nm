---
layout: post
title: Programming 
permalink: programming
categories: AIC
---

In IC design there will always come situation where you have to parse a text file, csv file, or something else, and translate into another format. 

For this, you need to learn a programming language.
The only way to learn programming is to first have a problem that you really need to solve, and then learn programming as a tool to solve it.

Some of the languages I would recommend are listed below.

## 1: Python3

It's the easiest to learn, most versitile programming language. There are excellent packages like numpy, pandas, seaborn, matplotlib, regex, json, yaml which makes reading csv files or other text files a breeze. 

### Why not use it
If things need to be ultra fast, then Python is not the right tool (although cython is an alternative) If you plan to give your code to someone who does not normally run python, then it's tricky

### Examples

- [cicsim](https://github.com/wulffern/cicsim)
- [cicconf](https://github.com/wulffern/cicconf)

## 2: C

If you're programming embedded, C is what you must learn.

### Why not use it

If Python will work

### Examples

- [nrf52-utilitycapture](https://github.com/wulffern/nrf52-utilitycapture)
- [nrfdmiq](https://github.com/wulffern/nrfdmiq) 

## 3: C++

### Why not use it
If Python will work or you're programming embedded, where dynamic memory allocation is a giant pain, or you're a SW engineer that needs to debug other peoples code. 

### Examples
- [ciccreator](https://github.com/wulffern/ciccreator)

## 4: C#
Fantastic for Windows programs, especially GUI. Fantasitc support from Visual Studio

### Why not use it
 If Python will work
 
### Examples
- [SystemDotNet.Report](https://github.com/wulffern/SystemDotNet.Report)

# Not recommended any more

## Perl

It's amazing for text parsing. It has amazing regular expression support. It's extremely concise (possible to write short programs) 

### Why not use it
It's been called a "write only" language, it's hard to read. See [JAPH](https://en.wikipedia.org/wiki/Just_another_Perl_hacker). Your code will be better in Python3. 

This is a fully functional useful Perl program

```bash
perl -p -i -e "s/\s+(\.SUBCKT)\s+(\w+)/${1} ${2}_CV/ig;" test.scs
```

### Examples
- [ocs](https://github.com/wulffern/ocs)