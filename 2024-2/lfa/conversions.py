from collections import defaultdict

from models import DFA, NFA, RRG, NFAε


def rrg_to_nfaε(G: RRG) -> NFAε:
    """
    Converte uma Gramática Linear Unitária à Direita (GLUD)
    em um Autômato Finito com Movimentos Vazios (AFε).
    """

    def initialize_transitions():
        """Inicializa um dicionário de transições para o AFε."""
        return {
            state: {symbol: set() for symbol in G.Σ | {"ε"}}
            for state in G.N | {"qf"}
        }

    def process_production(δ, A, production):
        """Processa uma única produção e atualiza as transições."""
        if production == "":
            δ[A]["ε"].add("qf")  # A -> ε gera δ(A, ε) = qf
            return
        for a in G.Σ:
            if production.startswith(a):
                B = production[len(a) :]
                if B:
                    δ[A][a].add(B)  # A -> aB gera δ(A, a) = B
                else:
                    δ[A][a].add("qf")  # A -> a gera δ(A, a) = qf
                return
        for B in G.N:
            if production.startswith(B):
                δ[A]["ε"].add(B)  # A -> B gera δ(A, ε) = B
                return

    transitions = initialize_transitions()
    for non_terminal, productions in G.P.items():
        for production in productions:
            process_production(transitions, non_terminal, production)

    return NFAε(Q=(G.N | {"qf"}), Σ=G.Σ, δ=transitions, q0=G.S, F={"qf"})


def nfaε_to_nfa(M: NFAε) -> NFA:
    """
    Converte um Autômato Finito com Movimentos Vazios (AFε)
    em um Autômato Finito Não Determinístico (AFN).
    """

    def epsilon_closure(states: set[str]):
        """Calcula o fecho vazio de um conjunto de estados do AFε."""
        closure = states  # Inicializa o fecho com os estados fornecidos
        stack = list(states)  # Pilha para processar os estados

        while stack:
            state = stack.pop()
            # Adiciona todos os estados alcançáveis por transições vazias
            for reachable_state in M.δ[state]["ε"]:
                if reachable_state not in closure:
                    closure.add(reachable_state)
                    # Adiciona novos estados à pilha
                    stack.append(reachable_state)

        return closure

    def compute_transition(state: str, symbol: str):
        """
        Calcula a transição para o AFN sem movimentos vazios.

        Obtém o fecho vazio do estado fornecido, determina os estados
        alcançáveis a partir desse fecho lendo o símbolo especificado
        e, por fim, obtém o fecho vazio do conjunto de estados resultante.
        """
        return epsilon_closure(
            set().union(
                *(
                    M.δ[reachable_state][symbol]
                    for reachable_state in epsilon_closure({state})
                )
            )
        )

    # Construção das transições do AFN com base no AFε
    transitions = {
        state: {symbol: compute_transition(state, symbol) for symbol in M.Σ}
        for state in M.Q
    }

    # Os estados finais do AFN são aqueles cujo
    # fecho vazio inclui um estado final do AFε
    final_states = {q for q in M.Q if epsilon_closure({q}) & M.F}

    return NFA(Q=M.Q, Σ=M.Σ, δ=transitions, q0=M.q0, F=final_states)


def nfa_to_dfa(M: NFA) -> DFA:
    """
    Converte um Autômato Finito Não Determinístico (AFN)
    em um Autômato Finito Determinístico (AFD).
    """
    unified_states = set()  # Estados unificados do tipo <q0q1...qf>
    initial_state = frozenset({M.q0})  # Estado inicial do AFN q0 vira <q0>
    transitions = defaultdict(dict)  # Transições do AFD
    stack = [initial_state]  # Pilha para processar os estados

    while stack:
        state = stack.pop()
        if state in unified_states:
            continue  # Estado já processado
        unified_states.add(state)

        for symbol in M.Σ:
            # Obtém o estado unificado contendo os estados alcançáveis
            # a partir do estado atual lendo o símbolo atual
            target = frozenset().union(*(M.δ[s][symbol] for s in state))

            # Adiciona a transição para o estado obtido
            # (ou None, se nenhum estado for alcançável)
            transitions[state][symbol] = target if target else None

            # Se o estado ainda não foi processado, adiciona-o à pilha
            if target and target not in unified_states:
                stack.append(target)

    # Os estados finais do AFD são os estados unificados
    # que contêm pelo menos um estado final do AFN
    final_states = {state for state in unified_states if state & M.F}

    return DFA(
        Q=unified_states,
        Σ=M.Σ,
        δ=transitions,
        q0=initial_state,
        F=final_states,
    )
