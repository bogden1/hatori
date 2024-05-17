import functools
import pickle
import heapq
import math
import numpy as np
import src.generator
import src.reader
import argparse

def setseed():
    np.random.seed(0)
    random.seed(0)

parser = argparse.ArgumentParser(description = '''Generates assets for the web app.
Optionally regenerates the data from which those assets are generated. To do so, set both --state and --docs''')
parser.add_argument('--state', '-s', help = 'Location of topic state file from Mallet, for example ../huge-data/debates/topic_state_500')
parser.add_argument('--docs', '-d', help = 'Location of Mallet input text, for example ../huge-data/debates/mc-20170814-stemmed.txt')
args = parser.parse_args()

if args.state and args.docs:
    data = src.reader.TextData(args.state, args.docs)
    data.counts
    data.sorts
    data.sums
    data.save("data/data.p")
elif args.state or args.docs:
    print(f'Must give both or neither of --state and --docs.', file = sys.stderr)

with open("data/data.p", "rb") as f:
    print("reading", flush=True)
    data = pickle.load(f)
    print("read", flush=True)

g = src.generator.Generator(data)
v = src.generator.Visualizer(data, "../docs/")

g.save("data/", "../docs/json/")
v.front("front/")
v.wordcloud("cloud/")
