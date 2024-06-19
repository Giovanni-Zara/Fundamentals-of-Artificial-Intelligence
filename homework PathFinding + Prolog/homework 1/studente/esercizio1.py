class Node:

    def __init__(self, state, h, path_cost=0, parent=None):
        self.state = state
        self.h = h
        self.path_cost = path_cost
        self.parent = parent

    def to_solution(self):
        seq = []
        node = self
        s0 = None
        while node is not None:
            if node.parent is None:
                s0 = node.state
            if node.parent is not None:
                seq.append(node.state)
            node = node.parent
        assert s0 is not None
        return list(reversed(seq))
    
    def __repr__(self):
        s = f'Node(state={self.state}, path_cost={self.path_cost}'
        s += ')' if self.parent is None else f', parent={self.parent.state})'
        return s


def a_star(
    initial_state,
    goal_test,
    successor_fn,
    heuristic_fn
):
    """Implementare l'algoritmo di ricerca A*.

    Parametri:
    - initial_state: posizione (x, y) della cella di partenza
    - goal_test: funzione da usare come goal_test(s), che ritorna
      True se e solo se s è uno stato di goal
    - successor_fn: funzione da usare come successor_fn(s), che ritorna
      una lista di tuple (s1, c) dove s1 è un successore di s, mentre
      c è il costo della transizione da s ad s1
    - heuristic_fn: funzione da usare come heuristic_fn(s), che ritorna
      un valore numerico.
    
    Questa funzione deve ritornare l'ultimo nodo della soluzione (un
    oggetto di tipo Node).
    """
    open_list = []
    start_node = Node(initial_state, heuristic_fn(initial_state), 0, None)
    open_list.append(start_node)
    closed_set = set()

    while open_list:
        open_list.sort(key=lambda x: x.path_cost + x.h)
        current_node = open_list.pop(0)

        if goal_test(current_node.state):
            return current_node

        closed_set.add(current_node.state)

        successors = successor_fn(current_node.state)
        for successor_state, cost in successors:
            if successor_state not in closed_set:
                g = current_node.path_cost + cost
                h = heuristic_fn(successor_state)
                successor_node = Node(successor_state, h, g, current_node)
                open_list.append(successor_node)

    return None


#Ho scelto di utilizzare la distanza di Manhattan come euristica per il problema.La scelta di questa euristica è giustificata in base alle caratteristiche del problema.
#La distanza di Manhattan è una misura di distanza tra due punti su una griglia rettangolare, calcolata come la somma delle differenze assolute delle coordinate x e y dei due punti.
# In questo caso, i punti sono lo stato attuale (s) e il goal.
#Questa euristica è appropriata perché l'agente si muove solo in orizzontale e in verticale sulla griglia, senza poter compiere movimenti diagonali.
# La distanza di Manhattan considera solo i movimenti orizzontali e verticali, ignorando le diagonali, ed è quindi un'euristica adatta per il problema.
#Ho implementato l'euristica in modo semplice e diretto, calcolando la distanza di Manhattan tra lo stato attuale e il goal senza ulteriori elaborazioni.
def heuristic(s, goal, is_solid):
    """Implementare l'euristica da utilizzare per l'esercizio 1.

    Parametri:
    - s: stato sul quale va calcolato il valore di h(s)
    - goal: posizione (x, y) della cella di goal
    - is_solid: funzione da usare come is_solid(p), che ritorna True
      se e solo se la cella in posizione p = (x_p, y_p) è piena
    
      Questa funzione deve ritornare un valore numerico.
    """
    return abs(s[0] - goal[0]) + abs(s[1] - goal[1])
