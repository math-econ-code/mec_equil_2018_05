import tensorflow as tf
import numpy as np

np.random.seed(0)

x_data = np.random.uniform(0, 1, 100)
y_data = x_data * 0.1 + 0.3

with tf.device('/gpu:0'):
    W = tf.Variable(tf.random_uniform([1], -1.0, 1.0))
    b = tf.Variable(tf.zeros([1]))
    y = W * x_data + b
    loss = tf.reduce_mean((y - y_data) ** 2)
    optimizer = tf.train.GradientDescentOptimizer(0.5)
    train = optimizer.minimize(loss)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for step in range(201):
    sess.run(train)
    if (step % 20 == 0):
        print(step, '-', sess.run(W), sess.run(b), "\n")
