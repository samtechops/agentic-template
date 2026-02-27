RUN:
    checkout a new/existing "my-feature" git branch

CREATE hello.py:
    print "hello agentic coding"
    print a concise explanation of the definition of ai agents

RUN:
    python hello.py
    git add .
    git commit -m "Demo agentic coding capabilities"

REPORT:
    respond with the exact output of hello.py
