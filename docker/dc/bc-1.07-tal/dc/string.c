/* 
 * implement string functions for dc
 *
 * Copyright (C) 1994, 1997, 1998, 2006, 2008, 2013
 * Free Software Foundation, Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

/* This should be the only module that knows the internals of type dc_string */

#include "config.h"

#include <stdio.h>
#ifdef HAVE_STDDEF_H
# include <stddef.h>	/* ptrdiff_t */
#else
# define ptrdiff_t	size_t
#endif
#ifdef HAVE_STDLIB_H
# include <stdlib.h>
#endif
#ifdef HAVE_STRING_H
# include <string.h>	/* memcpy */
#else
# ifdef HAVE_MEMORY_H
#  include <memory.h>	/* memcpy, maybe */
# else
#  ifdef HAVE_STRINGS_H
#   include <strings.h>	/* memcpy, maybe */
#  endif
# endif
#endif
#include "dc.h"
#include "dc-proto.h"

/* here is the completion of the dc_string type: */
struct dc_string {
	char *s_ptr;  /* pointer to base of string */
	size_t s_len; /* length of counted string */
	int  s_refs;  /* reference count to cut down on memory use by duplicates */
};


/* return a duplicate of the string in the passed value */
/* The mismatched data types forces the caller to deal with
 * bad dc_type'd dc_data values, and makes it more convenient
 * for the caller to not have to do the grunge work of setting
 * up a dc_type result.
 */
dc_data
dc_dup_str DC_DECLARG((value))
	dc_str value DC_DECLEND
{
	dc_data result;

	++value->s_refs;
	result.v.string = value;
	result.dc_type = DC_STRING;
	return result;
}

/* free an instance of a dc_str value */
void
dc_free_str DC_DECLARG((value))
	dc_str *value DC_DECLEND
{
	struct dc_string *string = *value;

	if (--string->s_refs < 1){
		free(string->s_ptr);
		free(string);
	}
}

/* Output a dc_str value.
 * Free the value after use if discard_flag is set.
 */
void
dc_out_str DC_DECLARG((value, discard_flag))
	dc_str value DC_DECLSEP
	dc_discard discard_flag DC_DECLEND
{
	fwrite(value->s_ptr, value->s_len, sizeof *value->s_ptr, stdout);
	if (discard_flag == DC_TOSS)
		dc_free_str(&value);
}

/* make a copy of a string (base s, length len)
 * into a dc_str value; return a dc_data result
 * with this value
 */
dc_data
dc_makestring DC_DECLARG((s, len))
	const char *s DC_DECLSEP
	size_t len DC_DECLEND
{
	dc_data result;
	struct dc_string *string;

	string = dc_malloc(sizeof *string);
	string->s_ptr = dc_malloc(len+1);
	memcpy(string->s_ptr, s, len);
	string->s_ptr[len] = '\0';	/* nul terminated for those who need it */
	string->s_len = len;
	string->s_refs = 1;
	result.v.string = string;
	result.dc_type = DC_STRING;
	return result;
}

/* make a copy of a dc_data and force it
 * to be a string (dc_data d)
 * into a dc_str value; return a dc_data result
 * with this value
 */
dc_data
dc_forcestring DC_DECLARG((d))
	dc_data d DC_DECLEND
{
	dc_data result;
	struct dc_string *string;

	string = dc_malloc(sizeof *string);
	string->s_ptr = dc_malloc(d.v.string->s_len+3);
	string->s_ptr[0]='[';
	memcpy(string->s_ptr+1, d.v.string->s_ptr, d.v.string->s_len);
	string->s_ptr[d.v.string->s_len+1] = ']';	    /* end of string */
	string->s_ptr[d.v.string->s_len+2] = '\0';	/* nul terminated for those who need it */
	string->s_len = d.v.string->s_len+2;
	string->s_refs = 1;
	result.v.string = string;
	result.dc_type = DC_STRING;
	return result;
}

/* make a copy of a dc_data and force it
 * to be a string (dc_data d)
 * into a dc_str value; return a dc_data result
 * with this value
 */
void
dc_strsep DC_DECLARG((a,b))
    dc_data a DC_DECLSEP
	dc_data b DC_DECLEND
{
    char *token, *string, *tofree;
    tofree = string = strdup(a.v.string->s_ptr);
    int count=0;
    struct dc_string *stab[1000];
    while ((token = strsep(&string, b.v.string->s_ptr)) != NULL) {
        struct dc_string *string;
        int len = strlen(token);
        string = dc_malloc(sizeof *string);
        string->s_ptr = dc_malloc(len+1);
        memcpy(string->s_ptr, token, len);
        string->s_ptr[len] = '\0';	/* nul terminated for those who need it */
        string->s_len = len;
        string->s_refs = 1;
        stab[count]=string;
        count++;
    }
    int rememberCount = count;
    while (count>0) {
        dc_data result;
        --count;
        result.v.string = stab[count];
        result.dc_type = DC_STRING;
        dc_push(result);
        
    }
    dc_push(dc_int2data(rememberCount));
    free(tofree);
}



/* make a copy of a dc_data and force it
 * to be a string (dc_data d)
 * into a dc_str value; return a dc_data result
 * with this value
 */
dc_data
dc_addstring DC_DECLARG((a,b))
    dc_data a DC_DECLSEP
	dc_data b DC_DECLEND
{
	dc_data result;
	struct dc_string *string;

	string = dc_malloc(sizeof *string);
	string->s_ptr = dc_malloc(a.v.string->s_len+b.v.string->s_len+1);
	memcpy(string->s_ptr, a.v.string->s_ptr, a.v.string->s_len);
	memcpy(string->s_ptr+a.v.string->s_len, b.v.string->s_ptr, b.v.string->s_len);
	string->s_ptr[a.v.string->s_len+b.v.string->s_len] = '\0';	/* nul terminated for those who need it */
	string->s_len = a.v.string->s_len+b.v.string->s_len;
	string->s_refs = 1;
	result.v.string = string;
	result.dc_type = DC_STRING;
	return result;
}

/* read a dc_str value from FILE *fp;
 * if ldelim == rdelim, then read until a ldelim char or EOF is reached;
 * if ldelim != rdelim, then read until a matching rdelim for the
 * (already eaten) first ldelim is read.
 * Return a dc_data result with the dc_str value as its contents.
 */
dc_data
dc_readstring DC_DECLARG((fp, ldelim, rdelim))
	FILE *fp DC_DECLSEP
	int ldelim DC_DECLSEP
	int rdelim DC_DECLEND
{
	static char *line_buf = NULL;	/* a buffer to build the string in */ 
	static size_t buflen = 0;		/* the current size of line_buf */
	int depth=1;
	int c;
	char *p;
	const char *end;

	if (line_buf == NULL){
		/* initial buflen should be large enough to handle most cases */
		buflen = (size_t) 2016;
		line_buf = dc_malloc(buflen);
	}
	p = line_buf;
	end = line_buf + buflen;
	for (;;){
		c = getc(fp);
		if (c == EOF)
			break;
		else if (c == rdelim && --depth < 1)
			break;
		else if (c == ldelim)
			++depth;
		if (p >= end){
			ptrdiff_t offset = p - line_buf;
			/* buflen increment should be big enough
			 * to avoid execessive reallocs:
			 */
			buflen += 2048;
			line_buf = realloc(line_buf, buflen);
			if (line_buf == NULL)
				dc_memfail();
			p = line_buf + offset;
			end = line_buf + buflen;
		}
		*p++ = c;
	}
	return dc_makestring(line_buf, (size_t)(p-line_buf));
}

/* read a dc_str value from a char;
 * Return a dc_data result with the dc_str value as its contents.
 */
dc_data
dc_char2string DC_DECLARG((mychar))
	char mychar DC_DECLEND
{
	static char line_buf[2] ;	/* a buffer to build the string in */ 
	*line_buf=mychar;
	return dc_makestring(line_buf,1);
}

/* return the base pointer of the dc_str value;
 * This function is needed because no one else knows what dc_str
 * looks like.
 */
const char *
dc_str2charp DC_DECLARG((value))
	dc_str value DC_DECLEND
{
	return value->s_ptr;
}

/* return the length of the dc_str value;
 * This function is needed because no one else knows what dc_str
 * looks like, and strlen(dc_str2charp(value)) won't work
 * if there's an embedded '\0'.
 */
size_t
dc_strlen DC_DECLARG((value))
	dc_str value DC_DECLEND
{
	return value->s_len;
}


/* initialize the strings subsystem */
void
dc_string_init DC_DECLVOID()
{
	/* nothing to do for this implementation */
}


/*
 * Local Variables:
 * mode: C
 * tab-width: 4
 * End:
 * vi: set ts=4 :
 */
