
def successors(s, is_solid, region_width, region_height):
    """Implementare le funzioni di successione e costo.

    Parametri:
    - s: stato del quale vanno calcolati i successori e i costi delle
      relative transizioni
    - is_solid: funzione da usare come is_solid(p) che ritorna True
      se e solo se la cella in posizione p è piena
    - region_width: numero di colonne della griglia
    - region_height: numero di righe della griglia

    Questa funzione deve ritornare una lista di tuple (s1, c), dove s1
    è un successore di s, mentre c è il costo della transizione da s
    ad s1.
    """
    x, y = s
    successors = []

    # Movimento verso l'alto
    if y > 0 :
        if (is_solid((x, y - 1))):
            costo = 100
        else:
            costo = 1
        successors.append(((x, y - 1), costo))
       

    # Movimento verso il basso
    if y < region_height - 1:
        if (is_solid((x, y + 1))):
            costo = 100
        else:
            costo = 1
        successors.append(((x, y + 1), costo))

    # Movimento verso sinistra
    if x > 0 :
        if (is_solid((x - 1, y))):
            costo = 100
        else:
            costo = 1
        successors.append(((x - 1, y), costo))
        
          
    # Movimento verso destra
    if x < region_width - 1 :
        if (is_solid((x + 1, y))):
            costo = 100
        else:
            costo = 1
        successors.append(((x + 1, y), costo))
        
         

    

    return successors


def heuristic(s, goal, is_solid, region_width, region_height):
    """Implementare l'euristica da utilizzare per l'esercizio 2.

    Parametri:
    - s: stato sul quale va calcolato il valore di h(s)
    - goal: posizione (x, y) della cella di goal
    - is_solid: funzione da usare come is_solid(p), che ritorna True
      se e solo se la cella in posizione p = (x_p, y_p) è piena
    - region_width: numero di colonne della griglia
    - region_height: numero di righe della griglia

      Questa funzione deve ritornare un valore numerico.
    """
    x, y = s
    goal_x, goal_y = goal

    # L'euristica utilizzata è la distanza di Manhattan tra lo stato attuale e il goal
    h = abs(goal_x - x) + abs(goal_y - y)

    # Aggiunta di un termine additivo per incoraggiare l'agente a rimanere lontano dalle celle piene
    for i in range(region_width):
        for j in range(region_height):
            if is_solid((i, j)):
                h -= 1

    return h
