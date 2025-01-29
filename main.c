/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: phudyka <phudyka@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/23 11:38:12 by phudyka           #+#    #+#             */
/*   Updated: 2025/01/29 11:50:51 by phudyka          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"

void	test_strlen()
{
    printf("\n--- Testing ft_strlen ---\n");

    printf("Original: %lu, Custom: %lu\n", strlen("Hello, World!"), ft_strlen("Hello, World!"));
    printf("Empty string: %lu, Custom: %lu\n", strlen(""), ft_strlen(""));
}

void	test_strcpy()
{
    printf("\n--- Testing ft_strcpy ---\n");

    char	dest[100];

    printf("Original: %s, Custom: %s\n", strcpy(dest, "Hello"), ft_strcpy(dest, "Hello"));
}

void	test_strcmp()
{
    printf("\n--- Testing ft_strcmp ---\n");
    printf("Compare same: %d, Custom: %d\n", strcmp("Hello", "Hello"), ft_strcmp("Hello", "Hello"));
    printf("Compare diff: %d, Custom: %d\n", strcmp("Hello", "World"), ft_strcmp("Hello", "World"));
}

void	test_write()
{
    printf("\n--- Testing ft_write ---\n");
    
    ssize_t ret;
    char *test_str = "Original write\n";
    ret = write(1, test_str, strlen(test_str));
    printf(" (ret = %zd)\n", ret);
    ret = ft_write(1, test_str, strlen(test_str));
    printf(" (ret = %zd)\n", ret);

    ret = ft_write(-1, "Error test\n", 11);
    printf("Error ret = %zd, errno = %d\n", ret, errno);
}

void test_read()
{
    printf("\n--- Testing ft_read ---\n");
    char buf[100];
    printf("Please enter some text (max 10 characters): ");
    fflush(stdout); 
    
    ssize_t ret = ft_read(0, buf, 10);
    if (ret > 0 && buf[ret-1] == '\n') {
        buf[ret-1] = '\0';
        ret--;
    }
    if (ret >= 0)
    {
        printf("\nRead: %s(ret = %zd)\n", buf, ret);
    }
    else
        printf("Error ret = %zd, errno = %d\n", ret, errno);
    
    // Test avec un mauvais descripteur de fichier
    printf("\nTesting with invalid file descriptor:\n");
    ret = ft_read(-1, buf, 10);
    printf("Error ret = %zd, errno = %d\n", ret, errno);
}

void	test_strdup()
{
    printf("\n--- Testing ft_strdup ---\n");

    char	*str = "Hello, World!";
    char	*dup = ft_strdup(str);

    if (dup)
	{
        printf("Original: %s, Duplicated: %s\n", str, dup);
        free(dup);
    }
	else
        printf("Error duplicating string, errno = %d\n", errno);
}

int	main(void)
{
    test_strlen();
    test_strcpy();
    test_strcmp();
    test_write();
    test_read();
    test_strdup();
    return (0);
}