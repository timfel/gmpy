#!/bin/bash

mx -p /home/tim/Dev/graalpython/graalpython-open python \
   --llvm.libraries="/usr/lib/x86_64-linux-gnu/libgmp.so:/usr/lib/x86_64-linux-gnu/libmpfr.so:/usr/lib/x86_64-linux-gnu/libmpc.so" \
   $@

exit

# needs the following patch as of May 16, 2018

From: Tim Felgentreff <timfelgentreff@gmail.com>
Date: Tue, 15 May 2018 16:40:56 +0200
Subject: [PATCH] HACK FOR GMPY

---
 graalpython/com.oracle.graal.python.cext/include/object.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/graalpython/com.oracle.graal.python.cext/include/object.h b/graalpython/com.oracle.graal.python.cext/include/object.h
index e5f689d0a9..41bd8588ad 100644
--- a/graalpython/com.oracle.graal.python.cext/include/object.h
+++ b/graalpython/com.oracle.graal.python.cext/include/object.h
@@ -89,10 +89,10 @@ whose size is determined when the object is allocated.
 
 #define PyObject_HEAD_INIT(type)        \
     { _PyObject_EXTRA_INIT              \
-    1, type },
+      1, type, 0 },
 
 #define PyVarObject_HEAD_INIT(type, size)       \
-    { PyObject_HEAD_INIT(type) size },
+    { _PyObject_EXTRA_INIT 1, type, size },
 
 /* PyObject_VAR_HEAD defines the initial segment of all variable-size
  * container objects.  These end with a declaration of an array with 1
@@ -112,10 +112,13 @@ typedef struct _object {
     _PyObject_HEAD_EXTRA
     Py_ssize_t ob_refcnt;
     struct _typeobject *ob_type;
+    Py_ssize_t ob_size; /* Number of items in variable part */
 } PyObject;
 
 typedef struct {
-    PyObject ob_base;
+    _PyObject_HEAD_EXTRA
+    Py_ssize_t ob_refcnt;
+    struct _typeobject *ob_type;
     Py_ssize_t ob_size; /* Number of items in variable part */
 } PyVarObject;
 
-- 
2.14.1

