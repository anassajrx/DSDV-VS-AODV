import matplotlib.pyplot as plt

# Données pour DSDV
time_values_dsdv = [200, 400, 600, 800, 1000, 1200, 1400, 1600]
generated_packets_dsdv = [31946, 64330, 96709, 129098, 161480, 193845, 226213, 258590]
lost_packets_dsdv = [144, 235, 328, 419, 510, 602, 693, 786]

# Calcul du taux de perte de paquets en pourcentage pour DSDV
packet_loss_rate_dsdv = [(lost / generated) * 100 for lost, generated in zip(lost_packets_dsdv, generated_packets_dsdv)]

# Données pour AODV
time_values_aodv = [200, 400, 600, 800, 1000, 1200, 1400, 1600]
generated_packets_aodv = [32824, 66152, 99451, 132751, 166040, 199329, 232597, 265885]
lost_packets_aodv = [40, 40, 40, 40, 40, 40, 40, 40]

# Calcul du taux de perte de paquets en pourcentage pour AODV
packet_loss_rate_aodv = [(lost / generated) * 100 for lost, generated in zip(lost_packets_aodv, generated_packets_aodv)]

# Tracer les courbes pour le taux de perte de paquets en fonction du temps
plt.plot(time_values_dsdv, packet_loss_rate_dsdv, label='DSDV')
plt.plot(time_values_aodv, packet_loss_rate_aodv, label='AODV')

# Afficher les valeurs pour DSDV
for i, txt in enumerate(lost_packets_dsdv):
    plt.annotate(txt, (time_values_dsdv[i], packet_loss_rate_dsdv[i]), textcoords="offset points", xytext=(0,10), ha='center')

# Afficher les valeurs pour AODV
for i, txt in enumerate(lost_packets_aodv):
    plt.annotate(txt, (time_values_aodv[i], packet_loss_rate_aodv[i]), textcoords="offset points", xytext=(0,10), ha='center')

# Ajouter de titres et de légendes
plt.title('Packet Loss Rate over Time')
plt.xlabel('Time')
plt.ylabel('Packet Loss Rate (%)')
plt.legend()

# Afficher le graphique
plt.grid(True)
plt.show()
