class RRG:
    def __init__(
        self,
        N: set[str] = None,
        Σ: set[str] = None,
        P: dict[str, set[str]] = None,
        S: str = None,
    ):
        self.N = N if N is not None else set()
        self.Σ = Σ if Σ is not None else set()
        self.P = P if P is not None else {}
        self.S = S


class FA:
    def __init__(
        self,
        Q: set[str] = None,
        Σ: set[str] = None,
        δ: dict[str, dict[str, (set[str] | str)]] = None,
        q0: str = None,
        F: set[str] = None,
    ):
        self.Q = Q if Q is not None else set()
        self.Σ = Σ if Σ is not None else set()
        self.δ = δ if δ is not None else {}
        self.q0 = q0
        self.F = F if F is not None else set()


class NFAε(FA):
    pass


class NFA(FA):
    pass


class DFA(FA):
    pass
