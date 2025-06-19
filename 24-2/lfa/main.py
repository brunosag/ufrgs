import re
import sys

from conversions import nfa_to_dfa, nfaε_to_nfa, rrg_to_nfaε
from models import DFA, RRG


def parse_rrg(grammar_str: str) -> RRG:
    """
    Extrai uma Gramática Linear Unitária à Direita (GLUD)
    de sua representação em string.
    """
    grammar_pattern = (
        r".*=\({(?P<N>.+(,.+)*)}, {(?P<Σ>.+(,.+)*)}, P, (?P<S>.+)\)\n"
        r"P = {\n(?P<P>[\s\S]*)\n}"
    )
    match = re.search(grammar_pattern, grammar_str)
    if not match:
        print("Invalid grammar format.")
        sys.exit(1)

    groups = match.groupdict()

    G = RRG()
    G.N = set(groups["N"].split(","))
    G.Σ = set(groups["Σ"].split(","))
    G.S = groups["S"]
    for line in groups["P"].split(",\n"):
        left, right = [side.strip() for side in line.split("->")]
        G.P.setdefault(left, set()).add(right)

    return G


def recognize_word(M: DFA, w: str) -> bool:
    state = M.q0
    for symbol in w:
        if symbol not in M.Σ or state not in M.Q:
            return False
        state = M.δ[state][symbol]
        if state is None:
            return False
    return state in M.F


def main():
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <rrg_file> <words_file>")
        sys.exit(1)

    rrg_file = sys.argv[1]
    with open(rrg_file, "r") as file:
        rrg_content = file.read()

    words_file = sys.argv[2]
    with open(words_file, "r") as file:
        words = file.read().split(",")

    G = parse_rrg(rrg_content)
    M = nfa_to_dfa(nfaε_to_nfa(rrg_to_nfaε(G)))

    accept = [w for w in words if recognize_word(M, w)]
    reject = [w for w in words if w not in accept]

    print(f"\nW = {{{", ".join([f"'{w}'" for w in words])}}}")
    print("\nW ∩ ACEITA(M):", *[f"- '{word}'" for word in accept], sep="\n")
    print(
        "\nW ∩ REJEITA(M):", *[f"- '{word}'" for word in reject], "", sep="\n"
    )


if __name__ == "__main__":
    main()
