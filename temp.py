import matplotlib.pyplot as plt

# Create a simple vertical "stack" graph of 80 layers
layers = list(range(1, 81))

fig, ax = plt.subplots(figsize=(4, 10))

# Represent each layer as a point on a vertical line
ax.plot([1] * len(layers), layers, marker='s', linestyle='-')

# Label only some layers to avoid clutter
for i in range(0, 80, 5):
    ax.text(1.02, layers[i], f"L{i+1}", va='center', fontsize=6)

ax.set_ylim(0, 81)
ax.set_xlim(0.9, 1.2)
ax.set_yticks([1, 20, 40, 60, 80])
ax.set_yticklabels([1, 20, 40, 60, 80])
ax.set_xticks([])

ax.set_title("Code Llama – 80 Transformer Layers", fontsize=10)
ax.set_ylabel("Layer index (depth)")

plt.tight_layout()

image_path = "codellama_80_layers_graph.png"
plt.savefig(image_path, dpi=200)
plt.close(fig)

image_path
