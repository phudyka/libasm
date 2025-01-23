/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: phudyka <phudyka@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/23 11:38:12 by phudyka           #+#    #+#             */
/*   Updated: 2025/01/23 16:14:56 by phudyka          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"

size_t ft_strlen(const char *str);

int main(void)
{
    const char *test = "Hello, world!";
    printf("ft_strlen: %zu\n", ft_strlen(test));
    printf("strlen: %zu\n", strlen(test));

    // Test pointeur NULL
    errno = 0;
    printf("ft_strlen(NULL): %zu (errno: %d)\n", ft_strlen(NULL), errno);

    return 0;
}
