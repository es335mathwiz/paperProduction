(**
 * Copyright (C) 2007 Jeremy Michelson
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of version 3 of the GNU General Public License as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * The GNU General Public License is also available from 
 * http://www.gnu.org/copyleft/gpl.txt
 *
 *)

(* ::Package:: *)

BeginPackage["console`", {"JLink`"}]
(* need the Global so that any overloading of InstallJava works *)

(* I forget which builtin or JLink Mathematica file I stole this idiom from *)
Private`msgOff = (Head[General::shdw] === $Off);
Off[General::shdw];
(* don't clobber JLink`ShowJavaConsole; override it. *)
console`ShowJavaConsole::usage = "ShowJavaConsole[] shows the thread safe and
  feature-filled Java console.  The JavaConsole object is returned.
  See DisposeJavaConsole[] and JLink`ShowJavaConsole[].";

HideJavaConsole::usage = "HideJavaConsole[] hides (closes) the thread safe and
  feature-filled Java console.  It can be reshown with ShowJavaConsole[].
  See DisposeJavaConsole[].";

DisposeJavaConsole::usage = "DisposeJavaConsole[] hides (closes) the thread
  safe and feature-filled Java console, and frees the resources it was using.
  See HideJavaConsole[].";

ExecOnJavaConsole::usage = "ExecOnJavaConsole[\"method\", {arg1, arg2, ...}]
  invokes, with the specified arguments, the named method on the JavaConsole
  from within the Event Dispatch Thread.
  arg1, arg2, etc. must be Java objects.  See MakeJavaObject[expr].";

SaveJavaConsole::usage = "SaveJavaConsole[\"filename\"] saves (serializes)
  the JavaConsole to the named file.  The filename can be relative to
  the current directory (Directory[]) or absolute.
  See LoadJavaConsole[].";

LoadJavaConsole::usage = "LoadJavaConsole[\"filename\"] reads in a saved
  Java console from the named file and displays it.
  The filename must be one to which SaveJavaConsole[] was called.
  Note: there can only be one Java console, so if you already have a
  Java console, the loaded one will be a new window which contains the content
  of the saved console, but it will not be a true console.";

JavaConsoleDetectsDeadlock::usage = "JavaConsoleDetectsDeadlock[] returns
  True (False) if deadlock detections during stack dumps ('v' in the Java
  Console) is enabled (disabled).  JavaConsoleDetectsDeadLock[True | False]
  turns on (off) deadlock detection during thread stack dumps.
  Deadlock detection may not be available on all platforms.";

MakeJavaArray::usage = "MakeJavaArray[{obj1, obj2, ...}] is
equivalent to MakeJavaArray[\"java.lang.Object\", {obj1, obj2, ...}].
MakeJavaArray[class, {obj1, obj2, ...}] where class is a JavaClass
is a synonym for MakeJavAArray[\"class\", {obj1, obj2, ...}].
MakeJavaArray[\"class\", {obj1, obj2, ...}] makes an
array of type class[] containing the objects {obj1, obj2, ...}.  When
the objects obj1, ... are all the same type, this is essentially
equivalent to, say, MakeJavaObject[{obj1, obj2, ...}].  However,
MakeJavaObject is unable to make an array of, say, Object[] out of
a list of mixed types.  Thus, for example,
MakeJavaArray[\"java.lang.Integer\", {1, 3, 5}] is equivalent to
{MakeJavaObject[1], MakeJavaObject[3], MakeJavaObject[5]} and
MakeJavaObject[{1,3,5}] but MakeJavaArray[\"java.lang.Object\", {1, True}]
works whereas there is no way of making an equivalent object using just
MakeJavaObject.  The objects obj1, and so on, may themselves be Lists,
or Lists of Lists.  However, \"class\" must be a fully qualified type
that will hold the object.  For example, if the obj1, etc are all arrays
of type com.me.MyObject[] then one should use
MakeJavaArray[\"[Lcom.me.MyObject;\", {obj1, ...}].  Primitive
types (e.g. \"[I\") are supported, although in practice it may be
difficult to obtain long, char, float, short, and byte.
Notice that for nested arrays of nonprimitive objects, the usual rule
of inserting an 'L' between the last '[' and the start of the fully
qualified class name, and putting a ';' after the class name,
applies.  For example: 
   MakeJavaArray[\"[Ljava.lang.Number;\", {{3, 0.5}, {2.3, 2.7, 8.2, 10}}]
produces
   (JLink`Objects`vm1`JavaObject254393211420673)
but
   MakeJavaObject[{{3, 0.5}, {2.3, 2.7, 8.2, 10}}]
produces the error
   MakeJavaObject::arg: 
     MakeJavaObject cannot convert {{3,0.5},{2.3,2.7,8.2,10}} to a Java 
        object. It does not operate on arguments of that type";

Begin["Private`"]

(* Copied from progress.m *)
(* we need to know our directory name so we can find our Java classes.
   Note that DirectoryName gives the trailing '/'. *)
(*$JavaClassDir = DirectoryName[$Input] <> "Java";*)
(*But as usual, the Mathematica documentation has fooled me and that actually
  doesn't work.  So we will need a hack, that is not sufficiently
  general, and that is too bad. It is also overly broad so that, although it
  isn't a catch-all, it might work... *)
$JavaClassDir = {ToFileName[{$UserBaseDirectory, "Java"}],
                 ToFileName[{$UserBaseDirectory, "Applications", "Java"}],
                 ToFileName[{$UserBaseDirectory, "AddOns", "Java"}],
                 ToFileName[{$UserBaseDirectory, "Kernel", "Java"}],
                 ToFileName[{DirectoryName[$Input], "Java"}]
                };

InitConsole[] := 
  (InstallJava[];
   AddToClassPath[$JavaClassDir];
   LoadJavaClass["edu.osu.mps.jeremy.mathematica.JavaConsole"];
   LoadJavaClass["edu.osu.mps.jeremy.mathematica.EDTUtilities"];
  );

console`ShowJavaConsole[] := Module[{},
  InitConsole[];
  Return[JavaConsole`getAndShowInstance[]];
  ];

If[!msgOff, On[General::shdw]];

ExecOnJavaConsole[method_String, args_List] := Module[{console},
  InitConsole[];
  (* this idiom with the console variable and ReleaseJavaObject is preferable
   * to BeginJavaBlock[] or JavaBlock[] here, because it will release the
   * object returned by ShowJavaConsole[] as well
   *)
  EDTUtilities`invoke[method,
                      console = JavaConsole`getInstance[], 
                      args
                     ];
  ReleaseJavaObject[console];
];  

HideJavaConsole[] := JavaBlock[ (* for boolean! *)
  ExecOnJavaConsole["setVisible", {MakeJavaObject[False]}]
];

DisposeJavaConsole[] := ExecOnJavaConsole["dispose", {}];

(* ClassForName is a convenience function for converting primitive types
   into their
   corresponding classes.  For example "int"->int class, etc.
   Most of these are easily doable using LoadJavaClass and Class`ForName,
   but the primitives need to be done on a case by case basis. *)
(* First a way of converting the basename of the
   corresponding wrapper class into the Class object. E.g.
   PrimitiveClass["Long"]->JavaObject[java.lang.Class] which is the
   class object for long. *)
PrimitiveClass[class_String] := (
  InstallJava[];
  LoadJavaClass["java.lang."<>class];
  ToExpression[class<>"`"<>"TYPE"]
  );

ClassForName["boolean" | "Z"] := PrimitiveClass["Boolean"];
ClassForName["byte" | "B"] := PrimitiveClass["Byte"];
ClassForName["char" | "C"] := PrimitiveClass["Character"];
ClassForName["double" | "D"] := PrimitiveClass["Double"];
ClassForName["float" | "F"] := PrimitiveClass["Float"];
ClassForName["int" | "I"] := PrimitiveClass["Integer"];
ClassForName["long" | "J"] := PrimitiveClass["Long"];
ClassForName["short" | "S"] := PrimitiveClass["Short"];
ClassForName["void" | "V"] := PrimitiveClass["Void"];
ClassForName[class_String] := (
  InstallJava[];
  LoadJavaClass["java.lang.Class"];
  Class`forName[ClassName[LoadJavaClass[class]]]
  );

(* convenience function for converting e.g. "[[LFullyQualified;" to
   "[LFullyQualified;" but "[LFullyQualified;" to "FullyQualified".
   I.e. remove one nesting from the array, returning the base class
   if appropriate.  If the input does not correspond to an array,
   the it itself is returned.  I can think of two implementations...
*)
getComponentType[class_String] := Module[{retVal},


Off[System`Syntax::sntufn];
  retVal = StringReplace[class, RegularExpression["^\[L?"]->""];
On[System`Syntax::sntufn];
  If[StringTake[retVal, 1] == "[",
     Return[retVal],
     (*else*)
     Return[StringReplace[retVal, RegularExpression[";$"]->""]]
    ];
  (* alternate implementation *)
  retVal = ClassForName[class]@getComponent[];
  Return[retVal === Null, class, retVal@getName[]];
];

MakeJavaArray[class_String, objects_List] := Module[
  {thisObject, (* the object being considered from objects *)
   array, (* the array to return *)
   numObjects, (* Length[objects] *)
   n (* for iteration *)
  },
  numObjects = Length[objects];
  InstallJava[]; (* need to do this always *)
  BeginJavaBlock[];
  
  Check[ (* return $Failed on exception *)
    LoadJavaClass["java.lang.reflect.Array"];
  
    array = ReturnAsJavaObject[
      Array`newInstance[ClassForName[class], numObjects]
    ];
    Do[
      thisObject = objects[[n]];
      thisObject = Switch[thisObject,
        (* if it is a list, insert an array.  Either it is an array
           of depth one less than the array we are currently making;
           everything is a java.lang.Object[]; or there is an error. *)
        _List, MakeJavaArray[getComponentType[class], thisObject],  
        _?JavaObjectQ, thisObject,
        _Integer, MakeJavaObject[thisObject], (* so not N[...] *)
        _?NumericQ, MakeJavaObject[N[thisObject]], (* e.g. \[Pi] *)
        _, MakeJavaObject[thisObject] (* no other possibilities *)
      ];
      Array`set[array, n-1, thisObject],
      {n, numObjects}
    ];
    KeepJavaObject[array];
    EndJavaBlock[];
    Return[array];
  ,
  (* in case of an exception (e.g. ClassNotFoundException
     or ArrayStoreException *)
  EndJavaBlock[];
  Return[$Failed];
  , {Java::excptn}]
];

(* this assumes that JLink has been installed...otherwise where did
 * the JavaClass object come from? *)
MakeJavaArray[class_JavaClass, array_List] := 
  MakeJavaArray[ClassName[class], array];

MakeJavaArray[array_List] := 
  MakeJavaArray["java.lang.Object", array];

(* TODO: decide whether to have a 
   MakeJavaArray[class_JavaObject, array_List] version and, if so
   should it assume that class is a Class<?> object, or should it
   behave as MakeJavaArray[GetClass[class, array]] (or
   MakeJavaArray[class@getName[], array])
   ???
*)

JavaConsoleDetectsDeadlock::unavailable = "Deadlock detection is not available for this Java virtual machine";

(* Utility function for getting a ThreadMXBean *)
getThreadBean[] := Module[{threadBean},
  InstallJava[];
  LoadJavaClass["java.lang.management.ManagementFactory"];
  threadBean = ManagementFactory`getThreadMXBean[];
  Return[threadBean];
];

JavaConsoleDetectsDeadlock[enable_ /; MatchQ[enable, True | False]] := 
  Module[{threadBean},
    JavaBlock[
      threadBean = getThreadBean[];
      If[threadBean@isThreadContentionMonitoringSupported[],
         threadBean@setThreadContentionMonitoringEnabled[enable],
         (*else*)
         Message[JavaConsoleDetectsDeadlock::unavailable]
      ];
    ];
  ];

JavaConsoleDetectsDeadlock[] := Module[{threadBean, retVal},
  JavaBlock[
    threadBean = getThreadBean[];
    (* JavaBlock isn't freeing threadBean here even though that's the
       whole point of JavaBlock. *)
    retVal = threadBean@isThreadContentionMonitoringSupported[] &&
             threadBean@isThreadContentionMonitoringEnabled[];
    ReleaseJavaObject[threadBean];
    Return[retVal]
    ]
  ];

(* utility function to convert a filename to an absolute one.
   The idea is to check the beginning of the string and seeing if it
   corresponds to a root directory ("/") or not.
   The catch is doing this in an OS-independent way despite my
   not knowing a Mathematica API which helps.
   Fortunately, Java can help...
*)
ToAbsoluteFileName[filename_String] := Module[{roots, positions},
  InstallJava[];
  JavaBlock[
    LoadJavaClass["java.io.File"];
    roots = (#@getPath[])&/@File`listRoots[]; (* allowed path roots ("/") *)
    positions = StringPosition[filename, roots];
    Return[
      If[TrueQ[MemberQ[positions, {1, _}]],
         filename, (* it began with a root directory *)
         (* else, was relative *)
         ToFileName[Directory[], filename]
        ]
    ];
  ]  (* JavaBlock doesn't end with a semicolon *)
];

SaveJavaConsole::fileExists = "The file `1` already exists.  Please delete it.";

SaveJavaConsole::noConsole = "Unable to access the Java console to save it.";

LoadJavaConsole::fnf = "File `1` not found.";

SaveJavaConsole[filename_String] := 
  Module[{absName, console, byteStream, objectStream, fileStream},
    JavaBlock[ (* a little premature *)
      absName = ToAbsoluteFileName[filename]; (* called InstallJava for us *)
      If[FileType[absName] =!= None,
         Message[SaveJavaConsole::fileExists, absName];
         Return[]
        ];
      InitConsole[]; (* ibid, plus EDTUtilities *)
      console = JavaConsole`getInstance[]; (* not getAndShow! *)
      If[!JavaObjectQ[console], Message[SaveJavaConsole::noConsole]; Return[]];
      (* best to serialize in the Event Dispatch Thread.  Best not to do
         file IO in the EDT.  Therefore use a ByteArrayOutputStream *)
      byteStream = JavaNew["java.io.ByteArrayOutputStream"];
      objectStream = JavaNew["java.io.ObjectOutputStream", byteStream];
      EDTUtilities`invoke["prepareForSerialization", console, {objectStream}];
      EDTUtilities`invoke["writeObject", objectStream, {console}];
      objectStream@flush[];
      objectStream@close[];
      AbortProtect[ (* in lieu of a finally clause to close fileStream *)
        Check[ (* ibid *)
          fileStream = JavaNew["java.io.FileOutputStream", absName];
          fileStream@write[byteStream@toByteArray[]];
          fileStream@flush[];
          fileStream@close[];
        , fileStream@close[]
        ];
      ];
      byteStream@close[]; (* not really necessary *)
      (* done *)
    ] (* JavaBlock; no semicolon *)
  ]; (* SaveJavaConsole Module *)

LoadJavaConsole[filename_String] :=
  Module[{absName, console, byteStream, objectStream, fileStream, fileSize,
          bytes, pos},
    JavaBlock[ (* a little premature *)
      absName = ToAbsoluteFileName[filename]; (* called InstallJava for us *)
      If[FileType[absName] =!= File,
         Message[LoadJavaConsole::fnf, absName];
         Return[]
        ];
      InitConsole[]; (* loads classes, doesn't show the console *)
      (* best to serialize in the Event Dispatch Thread.  Best not to do
         file IO in the EDT.  Therefore use a ByteArrayInputStream
         and therefore a byte[] *)
      fileSize = FileByteCount[absName]; (* so know size of needed space *)
      LoadJavaClass["java.lang.reflect.Array"]; (* to make a byte[] *)
      LoadJavaClass["java.lang.Byte"]; (* for Byte`TYPE *)
      bytes = ReturnAsJavaObject[Array`newInstance[Byte`TYPE, fileSize]];
      AbortProtect[ (* in lieu of a finally clause to close fileStream *)
        Check[ (* ibid *)
          fileStream = JavaNew["java.io.FileInputStream", absName];
          For[pos = 0, pos < fileSize, Null, (* if can't read all at once *)
              pos += fileStream@read[bytes, pos, fileSize - pos];
          ];
          fileStream@close[];
        , fileStream@close[]
        ];
      ];
      byteStream = JavaNew["java.io.ByteArrayInputStream", bytes];
      objectStream = (* not any ObjectInputStream!  Need JLinkClassLoader! *)
        JavaNew["edu.osu.mps.jeremy.mathematica.JLinkObjectInputStream",
                byteStream];
      EDTUtilities`classInvoke["prepareForDeserialization",
                               "edu.osu.mps.jeremy.mathematica.JavaConsole",
                               {objectStream}
                              ];
      console = EDTUtilities`invoke["readObject", objectStream, {}];
      EDTUtilities`invoke["setVisible", console, MakeJavaArray[{True}]];
      objectStream@close[];
      byteStream@close[]; (* probably not necessary *)
      Return[console];
    ] (* end of JavaBlock; no semicolon *)
  ]; (* end of LoadJavaConsole Module *)

End[]

SetAttributes[{ShowJavaConsole, HideJavaConsole, DisposeJavaConsole,
               JavaConsoleDetectsDeadlock, ExecOnJavaConsole, MakeJavaArray},
              Protected];

EndPackage[]
